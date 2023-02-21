import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';

class UserRequests{

  Future<String> register(String name, String username, String email, String password) async{
    try{
      Response response = await post(
        Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/user/register'),
        body: {
          'name': name,
          'username': username,
          'email': email,
          'password': password
        }
      );

      Map responseMap = json.decode(response.body);
      return responseMap['msg'];

    }catch(e){
      print('Error: '+e.toString());
      return 'Hubo un error';
    }

  }

  
  
}

final userRequests = UserRequests();