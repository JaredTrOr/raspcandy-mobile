import 'package:flutter/material.dart';

class AlertMessage extends StatelessWidget {

  final String? title;
  final String? content;
  final String? image;

  const AlertMessage({super.key, this.title, this.content, this.image});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //title: Text(title!),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: AssetImage(image!)),
          const SizedBox(height: 10),
          Text(title!),
          const SizedBox(height: 10),
          Text(content!),
          const SizedBox(height: 10),
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