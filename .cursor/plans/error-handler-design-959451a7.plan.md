<!-- 959451a7-6f14-40a0-9bab-0591b8d0682a c7eb7f9e-8ddb-4dff-ad68-8216763f3b02 -->
# Error Handler Design Implementation

## Overview

Implement a comprehensive error handling system that supports Supabase authentication errors, Dio network errors, automatic retry with exponential backoff, and scenario-based UI error presentation (toast, snackbar, dialog, inline form errors).

## Core Error Architecture

### 1. Failure Hierarchy (`lib/core/error/failures.dart`)

Expand the existing `Failure` class to include:

- **Base Failure** with common properties (message, code, severity, isRetryable)
- **AuthFailure** - Supabase auth errors (invalid credentials, email not confirmed, etc.)
- **NetworkFailure** - Connection issues, timeouts
- **ServerFailure** - HTTP 4xx/5xx errors with status codes
- **ValidationFailure** - Input validation errors (for inline form errors)
- **CacheFailure** - Local storage errors
- **UnknownFailure** - Unexpected errors

### 2. Exception Handler (`lib/core/error/exception_handler.dart`)

Create a centralized exception-to-failure mapper that converts:

- `DioException` → `NetworkFailure` / `ServerFailure`
- `AuthApiException` / `AuthException` → `AuthFailure`
- `FormatException` / validation errors → `ValidationFailure`

### 3. Error Severity & Presentation Strategy (`lib/core/error/error_severity.dart`)

Define enum for error severity:

- **Critical** → Dialog (blocks user, requires acknowledgment)
- **High** → Snackbar (visible but dismissible)
- **Medium** → Toast (auto-dismiss, non-intrusive)
- **Low** → Inline (form field errors)

## Network Layer Enhancement

### 4. Dio Configuration (`lib/core/network/dio_client.dart`)

Replace the empty `ApiClient` with a configured Dio instance:

- Base URL from environment config
- Request/response interceptors
- Timeout configurations (connect, receive, send)
- Custom error handling interceptor

### 5. Retry Interceptor (`lib/core/network/interceptors/retry_interceptor.dart`)

Implement automatic retry logic:

- Exponential backoff strategy (1s, 2s, 4s, 8s)
- Retry only on specific conditions: network errors, 408/429/500/502/503/504 status codes
- Max retry attempts (configurable, default 3)
- Skip retry for 4xx errors (except 408, 429)

### 6. Logging Interceptor (`lib/core/network/interceptors/logging_interceptor.dart`)

Log requests/responses for debugging:

- Request details (method, URL, headers, body)
- Response details (status, data)
- Error details with stack traces
- Conditional logging based on flavor (verbose in dev, minimal in prod)

### 7. Auth Token Interceptor (`lib/core/network/interceptors/auth_interceptor.dart`)

Automatically attach Supabase session token:

- Get current session from Supabase client
- Add Authorization header to requests
- Handle token refresh on 401 responses

## Supabase Error Handling

### 8. Auth Exception Mapper (`lib/core/error/mappers/auth_exception_mapper.dart`)

Map Supabase auth exceptions to user-friendly messages:

- `invalid_credentials` → "Invalid email or password"
- `email_not_confirmed` → "Please verify your email address"
- `user_not_found` → "No account found with this email"
- Include error codes and retryable flags

## Repository Layer Updates

### 9. Enhanced Auth Network Source (`lib/features/authentication/data/source/auth_network_source.dart`)

Update the existing source to:

- Use the exception handler for all Supabase errors
- Remove the TODO comment on line 34
- Handle all Supabase auth exceptions comprehensively
- Return appropriate `AuthFailure` types with severity levels

## Presentation Layer

### 10. Error Display Helper (`lib/core/error/error_display_helper.dart`)

Create a utility for showing errors based on severity:

- `showError(BuildContext, Failure)` - routes to appropriate display method
- `showErrorDialog()` - for critical errors
- `showErrorSnackbar()` - for high severity
- `showErrorToast()` - for medium severity
- Returns error message strings for inline display

### 11. Error Display Widgets (`lib/core/error/widgets/`)

Create reusable error widgets:

- `ErrorDialog` - styled alert dialog for critical errors
- `ErrorSnackbar` - custom snackbar with retry button
- `InlineErrorText` - form field error text widget

## Testing Infrastructure

### 12. Test Helpers (`test/helpers/mock_failures.dart`)

Create mock failures for testing:

- Sample failures of each type
- Helper functions to generate test failures
- Mock exception scenarios

## Key Files to Create/Modify

**New files:**

- `lib/core/error/failures.dart` (expand existing)
- `lib/core/error/exceptions.dart`
- `lib/core/error/exception_handler.dart`
- `lib/core/error/error_severity.dart`
- `lib/core/error/mappers/auth_exception_mapper.dart`
- `lib/core/error/error_display_helper.dart`
- `lib/core/error/widgets/error_dialog.dart`
- `lib/core/error/widgets/error_snackbar.dart`
- `lib/core/error/widgets/inline_error_text.dart`
- `lib/core/network/dio_client.dart` (replace existing)
- `lib/core/network/interceptors/retry_interceptor.dart`
- `lib/core/network/interceptors/logging_interceptor.dart`
- `lib/core/network/interceptors/auth_interceptor.dart`
- `test/helpers/mock_failures.dart`

**Modified files:**

- `lib/features/authentication/data/source/auth_network_source.dart`
- `lib/features/authentication/presentation/bloc/sign_in/sign_in_bloc.dart`
- `lib/core/di/di_container.dart` (register Dio client)

## Example Usage Pattern

```dart
// In repository/data source
try {
  final response = await dioClient.post('/endpoint');
  return Right(response.data);
} catch (e) {
  final failure = ExceptionHandler.handleException(e);
  return Left(failure);
}

// In BLoC
result.fold(
  (failure) => emit(ErrorState(failure)),
  (data) => emit(SuccessState(data)),
);

// In UI
if (state is ErrorState) {
  ErrorDisplayHelper.showError(context, state.failure);
}
```

## Notes

- Sentry integration hooks will be added to `ExceptionHandler` but left empty for now
- All error messages should be localizable via `l10n` in future iterations
- Retry logic will not apply to authentication endpoints (to avoid account lockouts)
- Network connectivity checks can be added later using `connectivity_plus` package

### To-dos

- [ ] Create comprehensive failure hierarchy and exception types with severity levels
- [ ] Build centralized exception handler and Supabase auth exception mapper
- [ ] Configure Dio client with base configuration and register in DI container
- [ ] Implement retry, logging, and auth token interceptors
- [ ] Create error display helper and reusable error widgets (dialog, snackbar, inline)
- [ ] Refactor auth network source to use exception handler
- [ ] Update sign-in BLoC to handle failures properly and display errors appropriately
- [ ] Create test helpers with mock failures for unit testing