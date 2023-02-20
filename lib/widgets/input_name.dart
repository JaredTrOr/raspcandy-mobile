import 'package:flutter/material.dart';
import '../utils/color_util.dart';

class InputName extends StatelessWidget {
  final TextEditingController inputController;
  const InputName({super.key, required this.inputController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      decoration: InputDecoration(
        labelText: 'Nombre',
        hintText: 'Ingrese su nombre',
        filled: true,
        fillColor: getColor('white'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
          return 'Ingrese su nombre correctamente';
        }
        else{
          return null;
        }
      },
    );
  }
}