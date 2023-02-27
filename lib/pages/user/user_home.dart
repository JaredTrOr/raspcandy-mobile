import 'package:flutter/material.dart';
import 'package:raspcandy/providers/dispenser_provider.dart';
import 'package:raspcandy/providers/purchase_provider.dart';
import 'package:raspcandy/utils/color_util.dart';
import 'package:raspcandy/utils/message_util.dart';
import 'package:raspcandy/widgets/button.dart';

import '../../models/UserData.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  //Stateful variables
  int _candyValue = 0;
  int _sizeValue = 0;

  @override
  Widget build(BuildContext context) {
  //final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                _miniNavigationBar(context),
                const SizedBox(height: 20,),
                const Image(image: AssetImage('assets/images/candy_title.png')),
                const SizedBox(height: 35,),
                _candyButtons(),
                const SizedBox(height: 35,),
                const Image(image: AssetImage('assets/images/portion_title.png')),
                const SizedBox(height: 35,),
                _portionButtons(),
                const SizedBox(height: 60,),
                Button(text: 'Realizar compra', pressedButton: _purchaseCandy),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _miniNavigationBar(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Column(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              Text(userData.username, style: const TextStyle(color: Colors.pink),)
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, 'user_profile');
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'user_login');
          }, 
          child: Text(
            'Cerrar sesión', 
            style: TextStyle(
              color: getColor('primary')
            ),
          )
        )
      ],
    );
  }

  Widget _candyButtons(){
    return FutureBuilder(
      future: dispenserProvider.getDispenserCandies(),
      initialData: {},
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        print(snapshot.data);
        return Row(
          children: _createCandyButtons(snapshot.data),
        );
      },
    );
  }

  List<Widget> _createCandyButtons(Map? candyDispenserResponse){
    
    List? candyDispenserList = candyDispenserResponse!['candies'];
    List<Widget> listOfCandyButtons = [];

    var i = 0;
  
    candyDispenserList?.forEach((candy) {
      
      listOfCandyButtons.add(_candyButton(i, 'assets/images/candy_option_1.png', candy['candy_name']));
      listOfCandyButtons.add(const SizedBox(width: 10,));
      i++;
    });
  
    return listOfCandyButtons;
  }

  Widget _portionButtons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _sizeButton(0, 'Chico'),
        const SizedBox(height: 20,),
        _sizeButton(1, 'Mediano'),
        const SizedBox(height: 20,),
        _sizeButton(2, 'Grande'),
      ],
    );
  }

  Widget _candyButton(int flagValue, String image, String contentText){
    return  Column(
      children: [
        GestureDetector(
          onTap: () {
            //Operation
            setState(() {
              _candyValue = flagValue;
            });
          },
          child: Container(
              height: 100,
              width: 100,
              color: _candyValue == flagValue ? Colors.pink.shade200 : Colors.transparent,
              child: Image(
                image: AssetImage(image),
                width: 20.0,
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Text(contentText, style: const TextStyle(fontWeight: FontWeight.bold),)
      ],
    );
  }

  Widget _sizeButton(int flagValue, String contentText){
    return  Column(
      children: [
        GestureDetector(
          onTap: () {
            //Operation
            setState(() {
              _sizeValue = flagValue;
            });
          },
          child: Container(
              height: 100,
              width: 100,
              color: _sizeValue == flagValue ? Colors.pink.shade200 : Colors.transparent,
              child: const Image(
                image: AssetImage('assets/images/candy.png'),
                width: 20.0,
              ),
            ),
          ),
        const SizedBox(height: 10,),
        Text(contentText, style: const TextStyle(fontWeight: FontWeight.bold),)
      ],
    );
  }
  
  _purchaseCandy() async {
    //Print the values
    print('Tipo de dulce: $_candyValue');
    print('Tamaño: $_sizeValue');

    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      }
    );

    //Get the candyId 
    Map? candyIdResponse = await dispenserProvider.getDispenserCandyByPosition(_candyValue);
    String candyId = candyIdResponse['candy']!['_id']!;
    String candyName = candyIdResponse['candy']!['candy_name']!;
    String size = purchaseProvider.getSize(_sizeValue);
    String userId = userData.id.isNotEmpty ? userData.id : 'usuario anonimo';

    //Make the purchase
    Map? response = await purchaseProvider.insertPurchase(candyId ,candyName ,size, userId);    
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();

    //Display the message
    alertMessage.setAlertText = response;
    // ignore: use_build_context_synchronously
    alertMessage.displayMessage(context, () {});

  }
}