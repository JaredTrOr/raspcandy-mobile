import 'package:flutter/material.dart';

import '../utils/color_util.dart';

class InputForm extends StatelessWidget {

  final String labelText;
  final String hintText;
  final TextEditingController inputController;
  const InputForm({super.key, required this.labelText, required this.hintText, required this.inputController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        filled: true,
        fillColor: getColor('white'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if(value!.isEmpty){
          return 'Ingrese su ${labelText.toLowerCase()} correctamente';
        }
        return null;
      },
    );
  }
}