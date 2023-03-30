import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspcandy/models/user_data_provider.dart';
import 'package:raspcandy/providers/purchase_provider.dart';
import 'package:raspcandy/providers/user_provider.dart';
import 'package:raspcandy/widgets/button.dart';
import '../../widgets/back_button.dart';

class AdminUserProfile extends StatelessWidget {
  const AdminUserProfile({super.key});

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
                  const SizedBox(height: 15),
                  _createCandyPurchaseCards(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(text: 'Editar', color: 'orange',width: 0.32 , pressedButton: () {
                        Navigator.pushNamed(context, 'admin_user_edit', arguments: setState);
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
    return Column(
      children: [
        const Image(image: AssetImage('assets/images/profile.png')),
        const SizedBox(height: 30),
        Text(Provider.of<UserDataProvider>(context).getName, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
        const SizedBox(height: 15),
        Text(Provider.of<UserDataProvider>(context).getUsername, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
        const SizedBox(height: 15),
        Text(Provider.of<UserDataProvider>(context).getEmail, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
      ],
    );
  }

  Widget _createCandyPurchaseCards(BuildContext context){
    return FutureBuilder(
      future: purchaseProvider.getUserCandyPurchases(Provider.of<UserDataProvider>(context).getId),
      initialData: {},
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
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
              Map data = snapshot.data!;
              return Column(
                children: _createCards(data)
              );
            }
        }
      }
    );
  }

  List<Widget> _createCards(Map data){
    List<Widget> cards = [];

    cards..add(
      Text(
        'Pedidos totales: ${data['totalAmount']}', 
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)
      ),
    )..add(const SizedBox(height: 30));

    List<dynamic>? candyPurchases = data['candyPurchases'];

    if(candyPurchases != null){
      for(var candy in candyPurchases){
        cards.add(
          _createCandyCards(
            candy['typeOfCandy'], 
            candy['small'].toString(), 
            candy['medium'].toString(), 
            candy['big'].toString()
          )
        );
        cards.add(const SizedBox(height: 25,));
      }
    }

    return cards;
  }

  Widget _createCandyCards(String title, String amountSmall, String amountMedium, String amountBig){
    final card = Column(
      children: [ 
        Text(
          title.substring(0,1).toUpperCase() + title.substring(1), 
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(children: [Text(amountBig), const Text('Grande')]),
            const SizedBox(width: 30,),
            Column(children: [Text(amountMedium), const Text('Mediano')]),
            const SizedBox(width: 30,),
            Column(children: [Text(amountSmall), const Text('Chico')]),
          ],
        )
      ],
    );

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const <BoxShadow> [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(2,2)
          )
        ],
      ),
      child: card,
    );
  }


  //MAKE A COMPONENT WHEN IOT IS DONDE :,c
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

            Map? response = await userProvider.deleteUser(Provider.of<UserDataProvider>(context, listen: false).getId);

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