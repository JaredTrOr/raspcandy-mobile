import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class PurchaseProvider{

  Future<Map> insertPurchase(String candyId,String candyName, String size, String userId) async {
    try{
      Response response = await post(
        Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/purchase/insertPurchase'),
        body: {
          'candyId': candyId,
          'candyName': candyName,
          'size': size,
          'userId': userId,
        }
      );

      Map responseMap = json.decode(response.body);
      return responseMap;

    }catch(e){
      print('Error: '+e.toString());
      return {};
    }
  } 

  String getSize(int value){

    String candySize = '';
    switch(value){
      case 0: candySize = 'Chico'; break;
      case 1: candySize = 'Mediano'; break;
      case 2: candySize = 'Grande'; break;
    }

    return candySize;
  }
}

final purchaseProvider = PurchaseProvider();