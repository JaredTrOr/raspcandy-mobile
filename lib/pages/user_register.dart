import 'package:flutter/material.dart';
import 'package:raspcandy/providers/user_provider.dart';
import 'package:raspcandy/utils/message_util.dart';
import 'package:raspcandy/widgets/button.dart';
import 'package:raspcandy/widgets/candy_dispenser.dart';
import 'package:raspcandy/widgets/container.dart';
import 'package:raspcandy/widgets/input.dart';
import 'package:raspcandy/widgets/input_email.dart';
import 'package:raspcandy/widgets/input_name.dart';
import 'package:raspcandy/widgets/input_password.dart';

import '../widgets/logo.dart';

class UserRegister extends StatefulWidget {

  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  //String? successMessage; It's not used
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
                MainContainer(child: _registerForm()),
                const SizedBox(height: 30),
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
          InputPassword(inputController: passwordController),
          const SizedBox(height: 20,),
          Button(text: 'Registrarse', pressedButton: _registerButton),
          const SizedBox(height: 20,),
          const Text('¿Ya tienes una cuenta?', style: TextStyle(fontSize: 15)),
          TextButton(
            onPressed: (){
              //Go to login page  
              //Navigator.pushNamed(context, 'user_login');
              Navigator.pushReplacementNamed(context, 'user_login');
            }, 
            child: const Text('Iniciar sesión')
          )
        ],
      ),
    );
  }

  _registerButton() async {

    //Check the validation
    if (formKey.currentState!.validate()) {
      print('input validation, OK!!');

      showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        }
      );

      //Request to the backend
      Map? response = await userProvider.register(
        nameController.text.toString(),
        usernameController.text.toString(),
        emailController.text.toString(),
        passwordController.text.toString()
      );

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      //Set the alert messages
      alertMessage.setAlertText = response;
      alertMessage.setResponse = response;
      // ignore: use_build_context_synchronously
      alertMessage.displayMessage(context, (){});      
    }
  }
}