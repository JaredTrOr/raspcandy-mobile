import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspcandy/providers/admin_provider.dart';

import '../utils/message_util.dart';
import '../widgets/button.dart';
import '../widgets/candy_dispenser.dart';
import '../widgets/container.dart';
import '../widgets/input.dart';
import '../widgets/input_password.dart';
import '../widgets/logo.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

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
            'Administradores',
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
          TextButton(
            onPressed: (){
              //Go register page
              Navigator.pushReplacementNamed(context, 'user_login');
            }, 
            child: const Text('Iniciar sesión como usuario')
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

      Map? response = await adminProvider.login(usernameController.text.toString(), passwordController.text.toString());

       // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      //Set the alert messages
      alertMessage.setAlertText = response;
      // ignore: use_build_context_synchronously
      alertMessage.displayMessage(context , () {
        if(response.isNotEmpty){
          if (response['success']) {
            Map adminResponse = response['admin'];
            Map addressResponse = adminResponse['address'];

            /*
            Provider.of<AdminDataProvider>(context, listen: false)(
              adminResponse['_id'], 
              adminResponse['name'],
              adminResponse['username'], 
              adminResponse['password'], 
              adminResponse['email'],
              addressResponse['street'],
              addressResponse['number'],
              addressResponse['place']
            );
            */
            Navigator.pushReplacementNamed(context, 'admin_home');
          }
        }
      });
    }
  }
}

class AdminDataProvider {
}