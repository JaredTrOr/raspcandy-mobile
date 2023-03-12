import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspcandy/models/AdministratorDataProvider.dart';
import 'package:raspcandy/widgets/profile_icon.dart';

import '../../widgets/back_button.dart';
import '../../widgets/logout_button.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                _miniNavigationBar(context),
                const SizedBox(height: 20,),
                const Text(
                'Administración',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 50,),
                _createOptionCard(
                  'assets/images/user_option_image.png', 
                  'Usuarios', 
                  () => Navigator.pushNamed(context, 'admin_user_list')
                ),
                const SizedBox(height: 30,),
                _createOptionCard(
                  'assets/images/admin_option_image.png', 
                  'Administradores', 
                  () => Navigator.pushNamed(context, 'admin_admin_list')
                ),
                const SizedBox(height: 30,),
                _createOptionCard(
                  'assets/images/candy_option_image.png', 
                  'Dulcería', 
                  () => Navigator.pushNamed(context, 'candy_home')
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget _miniNavigationBar(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProfileIcon(
          text: Provider.of<AdministratorDataProvider>(context).getUsername,
          callback: () => Navigator.pushReplacementNamed(context, 'admin_admin_profile')
        ),
        LogoutButton(callback: () {
          Provider.of<AdministratorDataProvider>(context, listen: false).resetData();
          Navigator.pushReplacementNamed(context, 'admin_login');
        })
      ],
    );
  }

  Widget _createOptionCard(String image, String text, VoidCallback callback){
    final card = Column(
      children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image(
            image: AssetImage(image),
            height: 130,
            fit: BoxFit.fill,  
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(text, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
        )
      ],
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: const <BoxShadow> [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(2,10)
          )
        ],
      ),
      child: GestureDetector(
        onTap: callback,
        child: card,
      )
    );


  }
}