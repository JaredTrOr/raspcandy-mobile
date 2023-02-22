import 'package:flutter/material.dart';

import '../utils/color_util.dart';

class InputPassword extends StatefulWidget {
  final TextEditingController inputController;
  const InputPassword({super.key, required this.inputController});

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.inputController,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        hintText: 'Ingrese su contraseña',
        filled: true,
        fillColor: getColor('white'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(obscureText ? Icons.visibility_off: Icons.visibility),
        )
      ),
      validator: (value) {
        if(value!.isEmpty){
          return 'Ingrese su contraseña correctamente';
        }
        return null;
      },
    );
  }
}