import 'package:flutter/material.dart';
import 'package:raspcandy/providers/admin_provider.dart';
import 'package:raspcandy/providers/purchase_provider.dart';
import 'package:raspcandy/widgets/back_button.dart';

import '../../providers/user_provider.dart';
import '../../utils/message_util.dart';
import '../../widgets/button.dart';
import '../../widgets/container.dart';
import '../../widgets/input.dart';
import '../../widgets/input_email.dart';
import '../../widgets/input_name.dart';
import '../../widgets/input_password.dart';

class AdminUserCreate extends StatefulWidget {
  const AdminUserCreate({super.key});

  @override
  State<AdminUserCreate> createState() => _AdminUserCreateState();
}

class _AdminUserCreateState extends State<AdminUserCreate> {

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
                const SizedBox(height: 30),
                const SizedBox(height: 30),
                MainContainer(child: _registerForm()),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingBackButton(pressed: () => Navigator.pop(context))
    );
  }

  Widget _registerForm(){
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Crear usuario',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 50,),
          InputName(inputController: nameController),
          const SizedBox(height: 20,),
          InputForm(labelText: 'Usuario', hintText: 'Ingrese su usuario', inputController: usernameController),
          const SizedBox(height: 20,),
          InputEmail(inputController: emailController),
          const SizedBox(height: 20,),
          InputPassword(inputController: passwordController),
          const SizedBox(height: 20,),
          Button(text: 'Crear', pressedButton: _registerButton, color: 'green',),
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
      alertMessage.displayMessage(context, (){
        if(response.isNotEmpty) {
          if (response['success']) {
            Navigator.pop(context);
            adminProvider.getUsers();
          }
        }
      });      
    }
  }
}