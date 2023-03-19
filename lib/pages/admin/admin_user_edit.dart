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

class AdminUserEdit extends StatefulWidget {
  const AdminUserEdit({super.key});

  @override
  State<AdminUserEdit> createState() => _AdminUserEditState();
}

class _AdminUserEditState extends State<AdminUserEdit> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();


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
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    //Logo
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
                    InputPassword(inputController: passwordController),
                    const SizedBox(height: 30),
                    Button(text: 'Editar', pressedButton: _editUser, color: 'orange',),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingBackButton(pressed: () => Navigator.pushReplacementNamed(context, 'admin_user_profile')),
    );
  }

  _editUser() async {
    if (formKey.currentState!.validate()) {
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
            //SET THE DATA AGAIN WHEN THE USER IS BEING UPLOADED
            Provider.of<UserDataProvider>(context, listen: false).updateData(
              nameController.text.toString(), 
              userController.text.toString(), 
              passwordController.text.toString(), 
              emailController.text.toString()
            );
            Navigator.pushReplacementNamed(context, 'admin_user_profile');
          }
        }
      });
    }
  }
}