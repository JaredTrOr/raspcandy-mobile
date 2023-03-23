import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspcandy/providers/admin_provider.dart';
import 'package:raspcandy/utils/icon_util.dart';
import 'package:raspcandy/widgets/button.dart';

import '../../models/user_data_provider.dart';
import '../../widgets/back_button.dart';

class AdminUserList extends StatefulWidget {
  const AdminUserList({super.key});

  @override
  State<AdminUserList> createState() => _AdminUserListState();
}

class _AdminUserListState extends State<AdminUserList> {

  List<dynamic>? userListData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final data = await adminProvider.getUsers();
    setState(() {
      userListData = data;
    });
  }

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
                  Button(text: 'Crear usuario', color: 'green',pressedButton: () { 
                    Navigator.pushNamed(context, 'admin_user_create', arguments: fetchData);
                  }),
                  const SizedBox(height: 20,),
                  _userList(context) //I MADE A CHANGE HERE
                ],
              ),
            ),
          )
        ),
      ),
      floatingActionButton: FloatingBackButton(pressed: () => Navigator.pop(context)),
    );
  }

  Widget _userList(BuildContext context){
    switch(userListData){
      case null: 
        return const Image(
          width: 50,
          image: AssetImage('assets/images/loading.gif'),
        );
      default:
        if (userListData!.isEmpty) {
          return const Text('There is no data to display');
        } else {
          return _createUserList(context, userListData!);
        }
    }
  }

  Widget _createUserList(BuildContext context, List<dynamic> users) {
    print('user list ');
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
            Navigator.pushNamed(context, 'admin_user_profile', arguments: fetchData);
          },
        )
      );
    }

    return Column(
      children: userArray,
    );
  }
}