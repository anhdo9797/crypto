import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  const Space({Key? key, this.width = 16, this.height = 16}) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
