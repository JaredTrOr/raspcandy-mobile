import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';

class UserProvider{

  Future<String> getFavoriteCandy(String id) async {

    String favCandyMessage = '';

    try{
      Response response = await get(Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/user/favoriteCandy/$id'));
      Map responseMap = json.decode(response.body);

      favCandyMessage = responseMap['favorite_candy'] == '' ? 'Aún no hay favorito :c' : responseMap['favorite_candy'];

      return favCandyMessage;

    }catch(e){
      print('Error: '+e.toString());
      return '';
    }
  }

  Future<Map> register(String name, String username, String email, String password) async{
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
      return responseMap;

    }catch(e){
      print('Error: '+e.toString());
      return {};
    }
  }

  Future<Map> login(String username, String password) async {
    try{
      Response response = await post(
        Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/user/login'),
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
  
  Future<Map> update(String id, String name, String username, String email, String password) async{
    try{
      Response response = await put(
        Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/user/update'),
        body: {
          'id': id,
          'name': name,
          'username': username,
          'email': email,
          'password': password
        }
      );

      Map responseMap = json.decode(response.body);
      return responseMap;
    }catch(err){
      print('ERROR: $err');
      return {};
    }
  }

  Future<Map> deleteUser(String id) async {
    try{
      Response response = await delete(Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/user/delete/$id'));
      Map responseMap = json.decode(response.body);
      return responseMap;
    }catch(err){
      print('ERROR $err');
      return {};
    }
  }

}

final userProvider = UserProvider();