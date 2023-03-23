import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:raspcandy/models/user_data_provider.dart';
import 'package:raspcandy/providers/purchase_provider.dart';
import 'package:raspcandy/utils/color_util.dart';
import 'package:raspcandy/widgets/button.dart';

import '../../widgets/back_button.dart';
import '../../widgets/container.dart';

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
                  MainContainer(child: _profileCard(context)),
                  const SizedBox(height: 50),
                  const Text(
                    'Pedidos',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20),
                  _purchasesCard(context)
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingBackButton(pressed: () => Navigator.pop(context)),
    );
  }

  Widget _showPurchasesAndFavCandy(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text('Pedidos', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
            const SizedBox(height: 10),
            FutureBuilder(
              future: purchaseProvider.getUserAmountOfPurchases(Provider.of<UserDataProvider>(context).getId),
              initialData: '',
              builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.waiting: 
                    return const Image(
                      width: 30,
                      image: AssetImage('assets/images/loading.gif'),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                        snapshot.data!, 
                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 17)
                      );
                    }
                }
              }
            ),
          ],
        ),
        Column(
          children: const [
            Text('Dulce Favorito', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
            SizedBox(height: 10),
            Text('In process ...', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17)),
          ],
        ),

      ],
    );
  }

  Widget _profileCard(BuildContext context){
    return Column(
      children: [
        const Image(image: AssetImage('assets/images/profile.png')),
        const SizedBox(height: 30),
        Text(Provider.of<UserDataProvider>(context).getName, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        const SizedBox(height: 10),
        Text(Provider.of<UserDataProvider>(context).getEmail, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
        const SizedBox(height: 70),
        _showPurchasesAndFavCandy(context),
        const SizedBox(height: 30),
        Button(text: 'Editar perfil', pressedButton: () {
          Navigator.pushNamed(context, 'user_edit');
        })
      ],
    );
  }

  Widget _purchasesCard(BuildContext context){
    return FutureBuilder(
      future: purchaseProvider.getUserPurchases(Provider.of<UserDataProvider>(context).getId),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting: 
            return const Image(
              width: 90,
              image: AssetImage('assets/images/loading.gif'),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(children: _createPurchasesCards(snapshot.data));
            }
        }
      }
    );
  }

  List<Widget> _createPurchasesCards(List? information){
    List<Widget> cards = [];

    for(var cardInfo in information!){
      cards.add(
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.shopping_bag, color: getColor('green')!, size: 35,),
                  title: Text('Dulce comprado: ${cardInfo['candyName']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text('Tamaño: ${cardInfo['size']}'),
                      const SizedBox(height: 5),
                      Text('Fecha de compra: ${cardInfo['dateOfPurchase']}'),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      );
      cards.add(const SizedBox(height: 20,));
    }

    return cards;
  }
}