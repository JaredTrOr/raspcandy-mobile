import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';

class DispenserProvider{

  Future<Map> getDispenserCandies() async{
    try{
      Response response = await get(Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/dispenser/getDispenserCandies'));

      Map responseMap = json.decode(response.body);
      return responseMap;

    }catch(e){
      print('Error: '+e.toString());
      return {};
    }
  }

  Future<Map> getDispenserCandyByPosition(int position) async {
    try{
      Response response = await get(
        Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/dispenser/getDispenserCandyByPosition/$position'),
      );
      Map responseMap = json.decode(response.body);
      return responseMap;
    }catch(e){
      print('Error: '+e.toString());
      return {};
    }
  }


}
final dispenserProvider = DispenserProvider();