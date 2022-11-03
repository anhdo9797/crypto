import 'package:flutter_dotenv/flutter_dotenv.dart';

class Assets {
  Assets._();

  static const google = 'assets/images/google.png';

  static const onboard1 = 'assets/images/svg/onboard1.svg';
  static const onboard2 = 'assets/images/svg/onboard2.svg';
  static const onboard3 = 'assets/images/svg/onboard3.svg';

  //flags
  static const vi = 'assets/images/png/vi.png';
  static const en = 'assets/images/png/en.png';

  static String logo = dotenv.env['EVN'] == 'DEVELOPMENT'
      ? "assets/launcher_icon/logo_dev.png"
      : "assets/launcher_icon/logo.png";
}
