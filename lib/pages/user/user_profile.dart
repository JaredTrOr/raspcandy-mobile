import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspcandy/models/UserDataProvider.dart';
import 'package:raspcandy/providers/purchase_provider.dart';
import 'package:raspcandy/widgets/button.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Text(Provider.of<UserDataProvider>(context).getName, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
                  const SizedBox(height: 10),
                  Text(Provider.of<UserDataProvider>(context).getEmail, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
                  const SizedBox(height: 70),
                  _showPurchasesAndFavCandy(context),
                  const SizedBox(height: 30),
                  Button(text: 'Editar perfil', pressedButton: () {
                    Navigator.pushNamed(context, 'user_edit');
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showPurchasesAndFavCandy(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text('Pedidos', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            const SizedBox(height: 10),
            FutureBuilder(
              future: purchaseProvider.getUserAmountOfPurchases(Provider.of<UserDataProvider>(context).getId),
              initialData: '',
              builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                return Text(
                  snapshot.data!, 
                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)
                );
              }
            ),
          ],
        ),
        Column(
          children: const [
            Text('Dulce Favorito', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            SizedBox(height: 10),
            Text('In process ...', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
          ],
        ),

      ],
    );
  }
}