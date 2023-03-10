import 'package:flutter/material.dart';
import 'package:raspcandy/providers/admin_provider.dart';
import 'package:raspcandy/providers/purchase_provider.dart';
import 'package:raspcandy/utils/icon_util.dart';
import 'package:raspcandy/widgets/button.dart';

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
                  const SizedBox(height: 50,),
                  const Text(
                  'Usuarios',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Button(text: 'Crear usuario', pressedButton: () => Navigator.pushNamed(context, 'admin_user_create')),
                  const SizedBox(height: 20,),
                  _userList()
                ],
              ),
            ),
          )
        ),
      )
    );
  }

  Widget _userList(){
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
              return _createUserList(snapshot.data!);
            }
        }
      }
    );
  }

  Widget _createUserList(List<dynamic> users) {
    List<Widget> userArray = [];

    for (var user in users) {
      userArray.add(
        ListTile(
          leading: getCustomIcon('person', 30, 'primary'),
          title: Text('Nombre: ${user['name']}'),
          subtitle: _createTextOfAmountOfCandies(user['_id']),
          trailing: getCustomIcon('arrow', 25, 'primary'),
        )
      );
    }

    return Column(
      children: userArray,
    );
  }

  Widget _createTextOfAmountOfCandies(String id){
    return FutureBuilder(
      future: purchaseProvider.getUserAmountOfPurchases(id),
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
          return Text('Dulces comprados: ${snapshot.data}');
      }
    );
  }

  
}