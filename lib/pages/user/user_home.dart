import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspcandy/providers/dispenser_provider.dart';
import 'package:raspcandy/providers/motor_provider.dart';
import 'package:raspcandy/utils/color_util.dart';
import 'package:raspcandy/utils/icon_util.dart';
import 'package:raspcandy/widgets/button.dart';
import 'package:raspcandy/widgets/logout_button.dart';
import 'package:raspcandy/widgets/profile_icon.dart';

import '../../models/user_data_provider.dart';
import '../../providers/purchase_provider.dart';
import '../../utils/message_util.dart';

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
        ProfileIcon(
          text: Provider.of<UserDataProvider>(context).getUsername,
          callback: () => Navigator.pushNamed(context, 'user_profile')
        ),
        LogoutButton(callback: () {
          Provider.of<UserDataProvider>(context,listen: false).resetData();
          Navigator.pushReplacementNamed(context, 'user_login');
        })
      ],
    );
  }

  Widget _candyButtons(){
    return FutureBuilder(
      future: dispenserProvider.getDispenserCandies(),
      initialData: {},
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _createCandyButtons(snapshot.data)
        );
      },
    );
  }

  List<Widget> _createCandyButtons(Map? candyDispenserResponse){
    
    List? candyDispenserList = candyDispenserResponse!['candies'];
    List<Widget> listOfCandyButtons = [];

    var i = 0;
  
    candyDispenserList?.forEach((candy) {
      
      listOfCandyButtons.add(_candyButton(i, 'candy', candy['candy_name']));
      listOfCandyButtons.add(const SizedBox(width: 10,));
      i++;
    });
  
    return listOfCandyButtons;
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
              color: _candyValue == flagValue ? Colors.black : Colors.transparent,
              child: getCustomIcon('candy', 60, getColorIconsHome(flagValue)!)
            ),
          ),
          const SizedBox(height: 10,),
          Text(contentText, style: const TextStyle(fontWeight: FontWeight.bold),)
      ],
    );
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
            color: _sizeValue == flagValue ? Colors.black : Colors.transparent,
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
    //Provider creating an object
    final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);

    //Print the values
    print('Tipo de dulce: $_candyValue');
    print('Tamaño: $_sizeValue');

    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      }
    );

    //Move the motor
    /*
      Make the operation which moves the motor, once the motor has been moved
      it is time to make the insertion to the database indicateing that the operation
      and the purchase has been done succesfully.
    */

    /*
    if(await motorProvider.moveOperationalMotor(_candyValue, _sizeValue)){
      print('The motor has been moved');
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
    else{
      print('Motor didnt move');
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }*/

    
    //Make an if statement to check if the motor has been moved succesfuly
    //Get all the candy and user information to make the purchase 
    Map? candyIdResponse = await dispenserProvider.getDispenserCandyByPosition(_candyValue);
    String candyId = candyIdResponse['candy']!['_id']!; //Dispenser id of the three candies
    String candyName = candyIdResponse['candy']!['candy_name']!; //Unique name
    String size = purchaseProvider.getSize(_sizeValue);
    String userId = userDataProvider.getName.isNotEmpty ? userDataProvider.getId : 'usuario anónimo';

    //Make the purchase
    Map? response = await purchaseProvider.insertPurchase(candyId ,candyName ,size, userId); 

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  
    //Display the message
    alertMessage.setAlertText = response;
    // ignore: use_build_context_synchronously
    alertMessage.displayMessage(context, () {});
    
    //deleted branch test
  }
}