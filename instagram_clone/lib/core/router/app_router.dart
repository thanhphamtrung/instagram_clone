import 'package:go_router/go_router.dart';

import 'package:instagram_clone/core/router/app_route.dart';
import 'package:instagram_clone/features/authentication/presentation/screen/sign_in_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.login,
    routes: <GoRoute>[
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const SignInScreen(),
      ),
    ],
  );
}
