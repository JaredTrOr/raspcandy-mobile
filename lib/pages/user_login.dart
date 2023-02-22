import 'package:flutter/material.dart';
import 'package:raspcandy/providers/user_provider.dart';
import 'package:raspcandy/widgets/logo.dart';

import '../utils/message_util.dart';
import '../widgets/button.dart';
import '../widgets/candy_dispenser.dart';
import '../widgets/container.dart';
import '../widgets/input.dart';
import '../widgets/input_password.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController usernameController = TextEditingController();
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
                MainContainer(child: _loginForm()),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginForm(){ 
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Iniciar sesión',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 20,),
          InputForm(labelText: 'Usuario', hintText: 'Ingrese su usuario', inputController: usernameController),
          const SizedBox(height: 20,),
          InputPassword(inputController: passwordController),
          const SizedBox(height: 20,),
          Button(text: 'Iniciar sesión', pressedButton: _loginButton),
          const SizedBox(height: 20,),
          const Text('¿Aún no tienes una cuenta?', style: TextStyle(fontSize: 15)),
          TextButton(
            onPressed: (){
              //Go to login page  
              Navigator.pushNamed(context, 'user_register');
            }, 
            child: const Text('Registrarse')
          )
        ],
      ),
    );
  }

  _loginButton() async {
    if (formKey.currentState!.validate()) {
      print('input validation, OK!!');

      showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        }
      );

      Map? response = await userProvider.login(usernameController.text.toString(), passwordController.text.toString());

       // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      //Set the alert messages
      alertMessage.setAlertText(response);
      // ignore: use_build_context_synchronously
      alertMessage.displayMessage(context);

      //Add validation Of null because response['success'] can be null
      if(response.isNotEmpty){
        if (response['success']) {
          //Go to the other activity
          // . . . MQTT
          print('Welcome user!!');
          final user = response['user'];
          // ignore: use_build_context_synchronously
          //Navigator.pushNamed(context, 'user_home');
        }
      }
    }
  }
}