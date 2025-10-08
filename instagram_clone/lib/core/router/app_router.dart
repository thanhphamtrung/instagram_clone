import 'package:go_router/go_router.dart';

import 'package:instagram_clone/core/router/app_route.dart';
import 'package:instagram_clone/features/authentication/presentation/screen/sign_in_screen.dart';
import 'package:instagram_clone/features/authentication/presentation/screen/sign_up_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.signIn,
    routes: <GoRoute>[
      GoRoute(
        path: RoutePaths.signIn,
        name: RouteNames.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: RoutePaths.signUp,
        name: RouteNames.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
  );
}
