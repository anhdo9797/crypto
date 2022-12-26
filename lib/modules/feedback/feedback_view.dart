import 'package:flutter/material.dart';
import 'package:s_crypto/modules/base/base.dart';
import 'package:s_crypto/modules/feedback/feedback_view_model.dart';
import "package:s_crypto/share/utils/utils.dart";

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<FeedbackViewModel>(
      vmBuilder: (_) => FeedbackViewModel(),
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, FeedbackViewModel vm) {
    return Scaffold(
      body: ClipPath(
        clipper: OvalPainter(),
      ),
    );
  }
}

// class OvalPainter extends CustomPainter {
//   final paintConfig = Paint()
//     ..style = PaintingStyle.fill
//     ..color = Colors.red;

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Ellipse
//     canvas.drawOval(
//         Rect.fromLAWN(0, 0, SizeConfig().screenWidth, 200), paintConfig);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

class OvalPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double w = SizeConfig().screenWidth;
    double h = SizeConfig().screenHeight / 2;
    path.lineTo(0, h);
    path.lineTo(h, w);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
