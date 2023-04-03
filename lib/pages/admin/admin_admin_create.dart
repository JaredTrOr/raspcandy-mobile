import 'package:flutter/material.dart';
import 'package:raspcandy/providers/admin_provider.dart';
import 'package:raspcandy/widgets/back_button.dart';
import '../../providers/user_provider.dart';
import '../../utils/message_util.dart';
import '../../widgets/button.dart';
import '../../widgets/container.dart';
import '../../widgets/input.dart';
import '../../widgets/input_email.dart';
import '../../widgets/input_name.dart';
import '../../widgets/input_password.dart';

class AdminAdminCreate extends StatefulWidget {
  const AdminAdminCreate({super.key});

  @override
  State<AdminAdminCreate> createState() => _AdminAdminCreateState();
}

class _AdminAdminCreateState extends State<AdminAdminCreate> {

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Address controllers
  TextEditingController streetController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController placeController = TextEditingController();



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
                const SizedBox(height: 50),
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
            'Crear Administrador',
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
          const Text(
            'Dirección',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 20,),
          InputForm(labelText: 'Calle', hintText: 'Ingrese su calle', inputController: streetController),
          const SizedBox(height: 20,),
          InputForm(labelText: 'Número', hintText: 'Ingrese su número', inputController: numberController),
          const SizedBox(height: 20,),
          InputForm(labelText: 'Localidad', hintText: 'Ingrese su localidad', inputController: placeController),
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
      Map? response = await adminProvider.createAdmin(
        nameController.text.toString(),
        usernameController.text.toString(),
        emailController.text.toString(),
        passwordController.text.toString(),
        streetController.text.toString(),
        numberController.text.toString(),
        placeController.text.toString()
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
            final setState = ModalRoute.of(context)?.settings.arguments as Function;
            Navigator.pop(context);
            setState();
          }
        }
      });      
    }
  }
}