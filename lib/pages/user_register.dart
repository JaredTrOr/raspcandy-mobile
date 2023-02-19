import 'package:flutter/material.dart';
import 'package:raspcandy/utils/color_util.dart';
import 'package:raspcandy/widgets/button.dart';
import 'package:raspcandy/widgets/candy_dispenser.dart';
import 'package:raspcandy/widgets/container.dart';
import 'package:raspcandy/widgets/input.dart';

import '../widgets/logo.dart';

class UserRegister extends StatelessWidget {

  UserRegister({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                //Logo
                const SizedBox(height: 20),
                const Logo(),
                const SizedBox(height: 20),
                const CandyDispenserImage(width: 130),
                const SizedBox(height: 30),
                MainContainer(child: _registerForm())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerForm(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Registro',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 20,),
        InputForm(labelText: 'Nombre', hintText: 'Escriba su nombre', inputController: nameController),
        const SizedBox(height: 20,),
        InputForm(labelText: 'Usuario', hintText: 'Escriba su usuario', inputController: usernameController),
        const SizedBox(height: 20,),
        InputForm(labelText: 'Email', hintText: 'Escriba su email', inputController: emailController),
        const SizedBox(height: 20,),
        InputForm(labelText: 'Contraseña', hintText: 'Escriba su contraseña', inputController: passwordController),
        const SizedBox(height: 20,),
        Button(text: 'Registrarse', pressedButton: (){
          
        })
      ],
    );
  }

}