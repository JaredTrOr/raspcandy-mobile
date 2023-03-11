import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspcandy/providers/admin_provider.dart';
import 'package:raspcandy/providers/purchase_provider.dart';
import 'package:raspcandy/providers/user_provider.dart';
import 'package:raspcandy/utils/color_util.dart';
import 'package:raspcandy/utils/icon_util.dart';
import 'package:raspcandy/widgets/button.dart';

import '../../models/UserDataProvider.dart';
import '../../widgets/back_button.dart';

class AdminUserList extends StatelessWidget {
  const AdminUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  const Text(
                  'Usuarios',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Button(text: 'Crear usuario', color: 'purple',pressedButton: () { 
                    Navigator.pushNamed(context, 'admin_user_create');
                  }),
                  const SizedBox(height: 20,),
                  _userList(context)
                ],
              ),
            ),
          )
        ),
      ),
      floatingActionButton: FloatingBackButton(pressed: () {Navigator.pop(context);}),
    );
  }

  Widget _userList(BuildContext context){
    return FutureBuilder(
      future: adminProvider.getUsers(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting: 
            return const Image(
              width: 50,
              image: AssetImage('assets/images/loading.gif'),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return _createUserList(context,snapshot.data!);
            }
        }
      }
    );
  }

  Widget _createUserList(BuildContext context, List<dynamic> users) {
    List<Widget> userArray = [];

    for (var user in users) {
      userArray.add(
        ListTile(
          leading: getCustomIcon('person', 30, 'primary'),
          title: Text('Nombre: ${user['name']}'),
          subtitle: Text('Email: ${user['email']}'),
          trailing: getCustomIcon('arrow', 25, 'primary'),
          onTap: () {
            Provider.of<UserDataProvider>(context, listen: false).setData(
              user['_id'],
              user['name'],
              user['username'],
              user['password'],
              user['email']
            );
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, 'admin_user_profile');
          },
        )
      );
    }

    return Column(
      children: userArray,
    );
  }
  
}