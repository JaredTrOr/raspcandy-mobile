import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspcandy/models/admin_data_provider.dart';
import 'package:raspcandy/providers/admin_provider.dart';

import '../../widgets/back_button.dart';
import '../../widgets/button.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {

    final setState = ModalRoute.of(context)?.settings.arguments as Function;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                   _profileCard(context),
                  const SizedBox(height:50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(text: 'Editar', color: 'orange',width: 0.32 , pressedButton: () {
                        Navigator.pushNamed(context, 'admin_admin_edit', arguments: setState);
                      }),
                      const SizedBox(width: 10,),
                      Button(text: 'Borrar', color: 'delete', width: 0.32,pressedButton: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext contextDialog){
                            return _createAlertMessage(context, contextDialog);
                          }
                        );
                      }),
                    ],
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

  Widget _profileCard(BuildContext context){

    final adminProvider = Provider.of<AdministratorDataProvider>(context);

    return Column(
      children: [
        const Image(image: AssetImage('assets/images/profile.png')),
        const SizedBox(height: 30),
        Text(adminProvider.getName, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
        const SizedBox(height: 15),
        Text(adminProvider.getUsername, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
        const SizedBox(height: 15),
        Text(adminProvider.getEmail, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
        const SizedBox(height: 20),
        const Text('Dirección', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        const SizedBox(height: 15),
        Text('Calle: ${adminProvider.getStreet}', style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
        const SizedBox(height: 15),
        Text('Número: ${adminProvider.getNumber}', style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
        const SizedBox(height: 15),
        Text('Localidad: ${adminProvider.getPlace}', style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),

      ],
    );
  }

  Widget _createAlertMessage(BuildContext context, BuildContext contextDialog){
    return AlertDialog(
      title: const Text('¿Estas seguro de borrar este usuario?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(contextDialog);
          }, 
          child: const Text('Cancelar')
        ),
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () async {
            showDialog(
              context: contextDialog,
              builder: (contextDialog) {
                return const Center(child: CircularProgressIndicator());
              }
            );

            Map? response = await adminProvider.deleteAdmin(Provider.of<AdministratorDataProvider>(context, listen: false).getId);

            if(response.isNotEmpty){
              if(response['success']){
                // ignore: use_build_context_synchronously
                Navigator.of(contextDialog).pop(); //Close the screen
                // ignore: use_build_context_synchronously
                Navigator.of(contextDialog).pop(); //Close the screen
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                // ignore: use_build_context_synchronously
                final setState = ModalRoute.of(context)?.settings.arguments as Function;
                setState();
              }
            }
          }, 
        ),
      ],
    );
  }
}