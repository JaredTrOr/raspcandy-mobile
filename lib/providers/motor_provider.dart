import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class MotorProvider {

  Future<bool> moveOperationalMotor(int candyValue, int sizeValue) async {

    try{
      Response response = await post(
        Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/motor/'),
        body: {
          'candyValue': candyValue.toString(),
          'sizeValue': sizeValue.toString()
        }
      );

      Map responseMap = json.decode(response.body);
      if(responseMap['success']){
        return true;
      }
      else {
        return false;
      }

    }catch(e){
      print('Error: '+e.toString());
      return false;
    }
  }

}

final motorProvider = MotorProvider();