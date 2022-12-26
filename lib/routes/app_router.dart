import 'package:flutter/material.dart';
import 'package:s_crypto/modules/add_wallet/add_wallet.dart';
import 'package:s_crypto/modules/auth/auth_module.dart';
import 'package:s_crypto/modules/auth/forgot-password/forgot_password.dart';
import 'package:s_crypto/modules/coin_detail/coin_detail.dart';
import 'package:s_crypto/modules/feedback/feedback_view.dart';
import 'package:s_crypto/modules/home/home_view.dart';
import 'package:s_crypto/modules/onboard/onboard_view.dart';
import 'package:s_crypto/modules/splash/splash_view.dart';
import 'package:s_crypto/routes/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_app_switcher/secure_app_switcher.dart';

_buildPageTransition({required Widget child}) => CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 600),
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.5, 0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(tween),
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          ),
        );
      },
    );

class AppRouter {
  static final AppRouter _appRouter = AppRouter._internal();

  factory AppRouter() {
    return _appRouter;
  }

  AppRouter._internal();

  static final GoRouter routes = GoRouter(
    debugLogDiagnostics: true,
    observers: [secureAppSwitcherRouteObserver],
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
    routes: <GoRoute>[
      GoRoute(
          path: "coins/:coinId",
          pageBuilder: (context, state) {
            final id = state.params["coinId"] ?? "";
            return _buildPageTransition(
              child: SecureAppSwitcherPage(
                style: SecureMaskStyle.blurDark,
                child: CoinDetailView(id: id),
              ),
            );
          }),
      GoRoute(
        path: APP_PAGE.addWallet.toPath,
        name: APP_PAGE.addWallet.toName,
        pageBuilder: (context, state) =>
            _buildPageTransition(child: const AddWalletView()),
      ),
      GoRoute(
        path: APP_PAGE.feedback.toPath,
        name: APP_PAGE.feedback.toName,
        pageBuilder: (context, state) =>
            _buildPageTransition(child: const FeedbackView()),
      ),
    ],
  );
}
