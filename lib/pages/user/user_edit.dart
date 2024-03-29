import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspcandy/models/user_data_provider.dart';
import 'package:raspcandy/widgets/button.dart';
import 'package:raspcandy/widgets/container.dart';
import 'package:raspcandy/widgets/input.dart';
import 'package:raspcandy/widgets/input_email.dart';
import 'package:raspcandy/widgets/input_name.dart';
import 'package:raspcandy/widgets/input_password.dart';

import '../../providers/user_provider.dart';
import '../../utils/message_util.dart';
import '../../widgets/back_button.dart';

class UserEdit extends StatefulWidget {
  const UserEdit({super.key});

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    nameController.text = Provider.of<UserDataProvider>(context).getName;
    userController.text = Provider.of<UserDataProvider>(context).getUsername;
    emailController.text = Provider.of<UserDataProvider>(context).getEmail;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: MainContainer(
              child: Column(
                children: [
                  Form(
                    key: formKey1,
                    child: Column(
                    children: [
                      const Text('Editar perfil', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 30),
                      const Image(image: AssetImage('assets/images/profile.png')),
                      const SizedBox(height: 30),
                      InputName(inputController: nameController,),
                      const SizedBox(height: 30),
                      InputForm(inputController: userController, hintText: 'Ingresa tu usuario', labelText: 'Usuario'),
                      const SizedBox(height: 30),
                      InputEmail(inputController: emailController,),
                      const SizedBox(height: 30),
                      Button(text: 'Editar', pressedButton: _editUser),
                    ],
                  )),

                  Form(
                    key: formKey2,
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        const Text('Cambiar contraseña', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 30),
                        InputPassword(inputController: passwordController),
                        const SizedBox(height: 30),
                        Button(text: 'Cambiar contraseña', pressedButton: _changePassword, color: 'purple',),
                      ],
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingBackButton(pressed: () => Navigator.pop(context)),
    );
  }

  _editUser() async {
    if (formKey1.currentState!.validate()) {
      print('input validation, OK!!');

      showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        }
      );

      Map? response = await userProvider.update(
        Provider.of<UserDataProvider>(context, listen: false).getId,
        nameController.text.toString(),
        userController.text.toString(),
        emailController.text.toString(),
      );

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      //Set the alert messages
      alertMessage.setAlertText = response;
      alertMessage.setResponse = response;
      // ignore: use_build_context_synchronously
      alertMessage.displayMessage(context, (){
        if(response.isNotEmpty){
          if (response['success']) {
            //SET THE DATA AGAIN WHEN THE USER IS BEING UPLOADED
            Provider.of<UserDataProvider>(context, listen: false).updateData(
              nameController.text.toString(), 
              userController.text.toString(), 
              emailController.text.toString()
            );
          }
        }
      });
    }
  }

  _changePassword() async {
    if (formKey2.currentState!.validate()) {
      print('input validation, OK!!');

      showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        }
      );

      Map? response = await userProvider.changePassword(
        Provider.of<UserDataProvider>(context, listen: false).getId,
        passwordController.text.toString()
      );

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      //Set the alert messages
      alertMessage.setAlertText = response;
      alertMessage.setResponse = response;
      // ignore: use_build_context_synchronously
      alertMessage.displayMessage(context, (){
        if(response.isNotEmpty){
          if (response['success']) {
            Provider.of<UserDataProvider>(context, listen: false).changePassword(
              passwordController.text.toString(), 
            );
            passwordController.text = '';
          }
        }
      });
    }
  } 
}