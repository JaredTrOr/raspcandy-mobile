import 'package:flutter/material.dart';
import 'package:raspcandy/models/UserData.dart';
import 'package:raspcandy/widgets/button.dart';
import 'package:raspcandy/widgets/input.dart';
import 'package:raspcandy/widgets/input_email.dart';
import 'package:raspcandy/widgets/input_name.dart';
import 'package:raspcandy/widgets/input_password.dart';

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

  @override
  Widget build(BuildContext context) {
    nameController.text = userData.name;
    userController.text = userData.username;
    emailController.text = userData.email;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  //Logo
                  const Image(image: AssetImage('assets/images/profile.png')),
                  const SizedBox(height: 30),
                  InputName(inputController: nameController,),
                  const SizedBox(height: 30),
                  InputForm(inputController: userController, hintText: 'Ingresa tu usuario', labelText: 'Usuario'),
                  const SizedBox(height: 30),
                  InputEmail(inputController: nameController,),
                  const SizedBox(height: 30),
                  InputPassword(inputController: passwordController),
                  const SizedBox(height: 30),
                  Button(text: 'Editar', pressedButton: () {

                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}