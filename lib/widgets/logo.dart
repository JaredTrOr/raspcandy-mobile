import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double? width;
  final double? height;
  const Logo({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage('assets/images/title_logo.png'),
      width: width,
      height: height,
    );
  }
}