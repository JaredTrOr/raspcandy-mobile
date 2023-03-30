import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class PurchaseProvider{

  Future<List> getPurchases() async {
    try{
      Response response = await get(Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/purchase/getPurchases'));
      Map mapResponse = json.decode(response.body);
      List purchases = mapResponse['purchases'];
      return purchases;
    }catch(err){
      print('ERROR: $err');
      return [];
    }
  }

  Future<List> getUserPurchases(String id) async {
    try{
      Response response = await get(Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/purchase/getUserPurchase/$id'));
      Map mapResponse = json.decode(response.body);
      List candyPurchases = mapResponse['userPurchases'];
      return candyPurchases;
    }catch(err){
      print('ERROR: $err');
      return [];
    }
  }

  Future<String> getUserAmountOfPurchases(String id) async {
    try{
      Response response = await get(Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/purchase/getUserAmountOfPurchases/$id'));
      Map mapResponse = json.decode(response.body);
      String candyPurchases = mapResponse['amountOfPurchases'].toString();
      return candyPurchases;
    }catch(err){
      print('ERROR: $err');
      return '';
    }
  }

  Future<Map> getUserCandyPurchases(String id) async {
    try{
      Response response = await get(Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/purchase/getUserCandyPurchases/$id'));
      Map mapResponse = json.decode(response.body);
      return mapResponse;
    }catch(err){
      print('ERROR: $err');
      return {};
    }
  }

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