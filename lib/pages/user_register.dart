import 'package:flutter/material.dart';
import 'package:raspcandy/providers/user_provider.dart';
import 'package:raspcandy/utils/message_util.dart';
import 'package:raspcandy/widgets/button.dart';
import 'package:raspcandy/widgets/candy_dispenser.dart';
import 'package:raspcandy/widgets/container.dart';
import 'package:raspcandy/widgets/input.dart';
import 'package:raspcandy/widgets/input_email.dart';
import 'package:raspcandy/widgets/input_name.dart';

import '../widgets/logo.dart';

class UserRegister extends StatefulWidget {

  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  String? successMessage;
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                //Logo
                const SizedBox(height: 30),
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
    return Form(
      key: formKey,
      child: Column(
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
          InputName(inputController: nameController),
          const SizedBox(height: 20,),
          InputForm(labelText: 'Usuario', hintText: 'Ingrese su usuario', inputController: usernameController),
          const SizedBox(height: 20,),
          InputEmail(inputController: emailController),
          const SizedBox(height: 20,),
          InputForm(labelText: 'Contraseña', hintText: 'Ingrese su contraseña', inputController: passwordController),
          const SizedBox(height: 20,),
          Button(text: 'Registrarse', pressedButton: () async {

            //Check the validation
            if(formKey.currentState!.validate()){
              print('input validation, OK!!');

              //Request to the backend
              Map? response = await userProvider.register(
                nameController.text.toString(),
                usernameController.text.toString(),
                emailController.text.toString(),
                passwordController.text.toString()
              );

              alertMessage.setAlertText(response);
              // ignore: use_build_context_synchronously
              alertMessage.displayMessage(context);

              if(response['success']){
                //Go to the other activity
                // . . .
                print('Welcome user!!');
              }
            }
          })
        ],
      ),
    );
  }
}