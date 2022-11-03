import 'package:flutter/material.dart';
import 'package:flutter_boiler/data/local/pref.dart';
import 'package:flutter_boiler/providers/auth_provider.dart';
import 'package:flutter_boiler/routes/routes.dart';
import 'package:flutter_boiler/share/constants/app_type.dart';
import 'package:flutter_boiler/share/utils/size_config.dart';
import 'package:flutter_boiler/share/widgets/app_logo.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = SizeConfig();
    size.init(context);

    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final GoRouter goRouter = GoRouter.of(context);

    appInit(authProvider, goRouter);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppLogo(
              key: const ValueKey("appLogo"),
              size: size.screenWidth * 0.5,
            ),
          ],
        ),
      ),
    );
  }

  appInit(AuthProvider authProvider, GoRouter goRouter) async {
    await Future.delayed(const Duration(seconds: 1));
    goRouter.goNamed(APP_PAGE.onboard.toName);

    // if (AppPref.firstInstall) {
    //   goRouter.goNamed(APP_PAGE.onboard.toName);
    // } else {
    //   final value = await authProvider.getMe();

    //   if (value == AuthStatus.loggedIn) {

    //   } else {
    //     goRouter.goNamed(APP_PAGE.auth.toName);
    //   }
    // }

    FlutterNativeSplash.remove(); // remove native splash
  }

  @override
  void dispose() {
    super.dispose();
  }
}
