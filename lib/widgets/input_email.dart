import 'package:flutter/material.dart';
import '../utils/color_util.dart';

class InputEmail extends StatelessWidget {
  final TextEditingController inputController;
  const InputEmail({super.key, required this.inputController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Ingrese su email',
        filled: true,
        fillColor: getColor('white'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)){
          return 'Ingrese su email correctamente';
        }
        else{
          return null;
        }
      },
    );
  }
}