import 'package:flutter/material.dart';

import '../utils/color_util.dart';

class LogoutButton extends StatelessWidget {

  final VoidCallback callback;

  const LogoutButton({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callback, 
      child: Text(
        'Cerrar sesión', 
        style: TextStyle(
        color: getColor('pink'),
          fontWeight: FontWeight.bold
        ),
      )
    );
  }
}