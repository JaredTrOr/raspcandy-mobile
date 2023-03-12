import 'package:flutter/material.dart';

final _colors = <String,Color> {
  'primary': Colors.pink.shade300,
  'purple': Colors.purple.shade300,
  'orange': Colors.orange.shade300,
  'red': Colors.red.shade400,
  'white': Colors.white,
  'black': Colors.black,
  'green': Colors.green.shade300,
  'light-gray': const Color(0xFFEDEDED),
  'delete': const Color.fromARGB(255, 177, 58, 70)
};

Color? getColor(String? color){
  return _colors[color];
}

String? getColorIconsHome(int? position){
  String color = '';
  switch(position){
    case 0: color ='red'; break;
    case 1: color = 'green'; break;
    case 2: color = 'orange'; break;
  }

  return color;
}