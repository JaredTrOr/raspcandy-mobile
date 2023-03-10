import 'package:flutter/material.dart';
import 'package:raspcandy/utils/color_util.dart';

class Button extends StatelessWidget{

  final String text;
  final VoidCallback pressedButton;
  final String? color;
  final double? width;

  const Button({super.key, required this.text, required this.pressedButton, this.color, this.width});
  
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return ElevatedButton(
      onPressed: pressedButton, 
      style: ElevatedButton.styleFrom(backgroundColor: getColor(color)),
      child: Container(
        width: width != null ? screenSize.width * width!.toDouble() : screenSize.width * 0.9,
        height: 60,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text, style: 
            TextStyle(
              color: getColor('white'),
            )
          ),
        ),
      ),
    );
  }

}



