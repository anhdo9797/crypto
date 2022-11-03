import 'package:flutter_boiler/modules/auth/auth_module.dart';
import 'package:flutter_boiler/modules/auth/forgot-password/forgot_password.dart';
import 'package:flutter_boiler/modules/home/home_view.dart';
import 'package:flutter_boiler/modules/onboard/onboard_view.dart';
import 'package:flutter_boiler/modules/splash/splash_view.dart';
import 'package:flutter_boiler/routes/routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final AppRouter _appRouter = AppRouter._internal();

  factory AppRouter() {
    return _appRouter;
  }

  AppRouter._internal();

  static final GoRouter routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: <GoRoute>[
      GoRoute(
        path: APP_PAGE.splash.toPath,
        name: APP_PAGE.splash.toName,
        builder: (context, GoRouterState state) => const SplashView(),
      ),
      GoRoute(
        path: APP_PAGE.onboard.toPath,
        name: APP_PAGE.onboard.toName,
        builder: (context, GoRouterState state) => const OnboardView(),
      ),
      authRouter,
      mainRouter
    ],
  );

  static final authRouter = GoRoute(
    path: APP_PAGE.auth.toPath,
    name: APP_PAGE.auth.toName,
    builder: (context, GoRouterState state) => const LoginView(),
    routes: <GoRoute>[
      GoRoute(
        path: APP_PAGE.register.toPath,
        name: APP_PAGE.register.toName,
        builder: (context, GoRouterState state) => const RegisterView(),
      ),
      GoRoute(
        path: APP_PAGE.forgotPassword.toPath,
        name: APP_PAGE.forgotPassword.toName,
        builder: (context, GoRouterState state) => const ForgotPasswordView(),
      ),
    ],
  );

  static final mainRouter = GoRoute(
    path: APP_PAGE.home.toPath,
    name: APP_PAGE.home.toName,
    builder: (context, GoRouterState state) => const HomeView(),
  );
}
