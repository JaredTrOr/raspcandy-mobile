import 'package:flutter/material.dart';
import 'package:raspcandy/utils/icon_util.dart';

class AlertMessage extends StatelessWidget {

  final String title;
  final String content;
  final String image;
  final String color;

  const AlertMessage({super.key, required this.title, required this.content, required this.image, required this.color});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //title: Text(title!),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Icon of the alert message
          getCustomIcon(image, 60, color),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
          const SizedBox(height: 20),
          Text(content),
        ],
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        )
      ],
    );
  }
}