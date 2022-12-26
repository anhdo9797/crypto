// ignore: camel_case_types
enum APP_PAGE {
  splash,
  onboard,
  auth,
  register,
  forgotPassword,
  home,
  addWallet,
  feedback,
}

extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch (this) {

      /** auth router */
      case APP_PAGE.auth:
        return "/auth";
      case APP_PAGE.register:
        return "register";
      case APP_PAGE.forgotPassword:
        return "forgot-password";

      case APP_PAGE.onboard:
        return "/onboard";

      case APP_PAGE.home:
        return "/home";
      case APP_PAGE.addWallet:
        return "add-wallet";
      case APP_PAGE.feedback:
        return "feedback";

      default:
        /** splash */
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case APP_PAGE.home:
        return "home";
      case APP_PAGE.auth:
        return "auth";
      case APP_PAGE.register:
        return "register";
      case APP_PAGE.forgotPassword:
        return "forgot-password";
      case APP_PAGE.onboard:
        return "onboard";
      case APP_PAGE.addWallet:
        return "addWallet";
      case APP_PAGE.feedback:
        return "feedback";
      default:
        return "splash";
    }
  }
}
