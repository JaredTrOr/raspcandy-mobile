import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspcandy/models/admin_data_provider.dart';

import '../../providers/admin_provider.dart';
import '../../utils/icon_util.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button.dart';

class AdminAdminList extends StatefulWidget {
  const AdminAdminList({super.key});

  @override
  State<AdminAdminList> createState() => _AdminAdminListState();
}

class _AdminAdminListState extends State<AdminAdminList> {
  
  List<dynamic>? adminListData;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await fetchData();
    });
  }

  Future<void> fetchData() async {
    final data = await adminProvider.getAdmins(); //Get administrators
    setState(() {
      adminListData = data;
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
                    'Administradores',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Button(text: 'Crear administrador', color: 'green',pressedButton: () { 
                    Navigator.pushNamed(context, 'admin_admin_create', arguments: fetchData);
                  }),
                  const SizedBox(height: 20,),
                  _adminList(context) //I MADE A CHANGE HERE
                ],
              ),
            ),
          )
        ),
      ),
      floatingActionButton: FloatingBackButton(pressed: () => Navigator.pop(context)),
    );
  }

  Widget _adminList(BuildContext context){
    switch(adminListData){
      case null: 
        return const Image(
          width: 50,
          image: AssetImage('assets/images/loading.gif'),
        );
      default:
        if (adminListData!.isEmpty) {
          return const Text('There is no data to display');
        } else {
          return _createAdminList(context, adminListData!);
        }
    }
  }

  Widget _createAdminList(BuildContext context, List<dynamic> admins) {
    List<Widget> adminArray = [];

    for (var admin in admins) {
      adminArray.add(
        ListTile(
          leading: getCustomIcon('person', 30, 'primary'),
          title: Text('Nombre: ${admin['name']}'),
          subtitle: Text('Email: ${admin['email']}'),
          trailing: getCustomIcon('arrow', 25, 'primary'),
          onTap: () {

            Map adminAddress = admin['address'];admin['address'];

            Provider.of<AdministratorDataProvider>(context, listen: false).setData(
              admin['_id'],
              admin['name'],
              admin['username'],
              admin['password'],
              admin['email'],
              adminAddress['street']!,
              adminAddress['number']!,
              adminAddress['place']!,
            );
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, 'admin_admin_profile', arguments: fetchData);
          },
        )
      );
    }

    return Column(
      children: adminArray,
    );
  }



}