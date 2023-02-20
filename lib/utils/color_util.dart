import 'package:flutter/material.dart';

final _colors = <String,Color> {
  'primary': Colors.pink.shade300,
  'purple': Colors.purple.shade200,
  'orange': Colors.orange.shade300,
  'red': Colors.red.shade400,
  'white': Colors.white,
  'black': Colors.black,
  'green': Colors.green.shade300,
  'light-gray': const Color(0xFFEDEDED)
};

Color? getColor(String? color){
  return _colors[color];
}