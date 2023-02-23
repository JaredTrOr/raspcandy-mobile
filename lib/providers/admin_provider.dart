import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';

class AdminProvider{

  Future<Map> login(String username, String password) async {
    try{
      Response response = await post(
        Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/admin/loginAdmin'),
        body: {
          'username': username,
          'password': password
        }
      );

      Map responseMap = json.decode(response.body);
      return responseMap;

    }catch(e){
      print('Error: '+e.toString());
      return {};
    }
  }
  
}

final adminProvider = AdminProvider();