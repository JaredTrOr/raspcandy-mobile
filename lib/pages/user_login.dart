import 'package:flutter/material.dart';
import 'package:raspcandy/widgets/logo.dart';

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

  _loginButton(){

  }
}