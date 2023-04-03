import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspcandy/models/admin_data_provider.dart';
import 'package:raspcandy/models/user_data_provider.dart';
import 'package:raspcandy/providers/admin_provider.dart';
import 'package:raspcandy/widgets/button.dart';
import 'package:raspcandy/widgets/container.dart';
import 'package:raspcandy/widgets/input.dart';
import 'package:raspcandy/widgets/input_email.dart';
import 'package:raspcandy/widgets/input_name.dart';
import 'package:raspcandy/widgets/input_password.dart';

import '../../utils/message_util.dart';
import '../../widgets/back_button.dart';

class AdminAdminEdit extends StatefulWidget {
  const AdminAdminEdit({super.key});

  @override
  State<AdminAdminEdit> createState() => _AdminAdminEditState();
}

class _AdminAdminEditState extends State<AdminAdminEdit> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Address
  TextEditingController streetController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    nameController.text = Provider.of<AdministratorDataProvider>(context).getName;
    userController.text = Provider.of<AdministratorDataProvider>(context).getUsername;
    emailController.text = Provider.of<AdministratorDataProvider>(context).getEmail;
    streetController.text = Provider.of<AdministratorDataProvider>(context).getStreet;
    numberController.text = Provider.of<AdministratorDataProvider>(context).getNumber;
    placeController.text = Provider.of<AdministratorDataProvider>(context).getPlace;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: MainContainer(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text('Editar perfil', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 30),
                    const Image(image: AssetImage('assets/images/profile.png')),
                    const SizedBox(height: 30),
                    InputName(inputController: nameController),
                    const SizedBox(height: 30),
                    InputForm(inputController: userController, hintText: 'Ingresa el usuario', labelText: 'Usuario'),
                    const SizedBox(height: 30),
                    InputEmail(inputController: emailController,),
                    const SizedBox(height: 30),
                    InputPassword(inputController: passwordController),
                    const SizedBox(height: 30),
                    const Text(
                    'Dirección',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(height: 20,),
                    InputForm(inputController: streetController, hintText: 'Ingresa la calle', labelText: 'Calle'),
                    const SizedBox(height: 20,),
                    InputForm(inputController: numberController, hintText: 'Ingresa el número', labelText: 'Número'),
                    const SizedBox(height: 20,),
                    InputForm(inputController: placeController, hintText: 'Ingresa la localidad', labelText: 'Localidad'),
                    const SizedBox(height: 20,),
                    Button(text: 'Editar', pressedButton: _editUser, color: 'orange',),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingBackButton(pressed: () => Navigator.pop(context)),
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

      Map? response = await adminProvider.editAdmin(
        Provider.of<UserDataProvider>(context, listen: false).getId,
        nameController.text.toString(),
        userController.text.toString(),
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
        if(response.isNotEmpty){
          if (response['success']) {
            //SET THE DATA AGAIN WHEN THE USER IS BEING UPLOADED
            Provider.of<AdministratorDataProvider>(context, listen: false).updateData(
              nameController.text.toString(), 
              userController.text.toString(), 
              passwordController.text.toString(), 
              emailController.text.toString(),
              streetController.text.toString(),
              numberController.text.toString(),
              placeController.text.toString()
            );
            final setState = ModalRoute.of(context)?.settings.arguments as Function;
            setState();
            Navigator.pop(context);
          }
        }
      });
    }
  }
}