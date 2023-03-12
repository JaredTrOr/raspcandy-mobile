import 'package:flutter/material.dart';
import 'package:raspcandy/utils/color_util.dart';
import 'package:raspcandy/utils/icon_util.dart';

class FloatingBackButton extends StatelessWidget {

  final VoidCallback pressed;

  const FloatingBackButton({super.key, required this.pressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: getColor('primary'),
      onPressed: pressed,
      child: getIcon('back')
    );
  }
}