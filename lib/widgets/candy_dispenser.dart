import 'package:flutter/material.dart';

class CandyDispenserImage extends StatelessWidget {
  final double? width;
  final double? height;
  const CandyDispenserImage({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage('assets/images/candy_dispenser.png'),
      width: width,
      height: height,
    );
  }
}