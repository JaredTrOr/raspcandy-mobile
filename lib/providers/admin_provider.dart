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
  
  Future<List<dynamic>> getUsers() async {
    try{
      Response response = await get(Uri.parse('${dotenv.get('NGROK_URL', fallback:'')}/admin/getUsers'));
      Map responseMap = json.decode(response.body);
      if(responseMap.isNotEmpty){
        List<dynamic> users = responseMap['users'];
        return users; 
      }else{
        return [];
      }
    }catch(e){
      print('Error: '+e.toString());
      return [];
    }
  }

  Future<Map> getUserInformation(String? id) async {
    try{
      Response response = 
      await get(Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/admin/getUserInformation/$id'));

      Map responseMap = json.decode(response.body);
      return responseMap['user'];
    }catch(e){
      print('Error: '+e.toString());
      return {};
    }
  }

  void getUserInformationAfterDelete(String id) async {
      await get(Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/admin/getUserInformation/$id'));
  }

  Future<List<dynamic>> getAdmins() async {
    try{
      Response response = await get(Uri.parse('${dotenv.get('NGROK_URL', fallback:'')}/admin/getAdmins'));
      Map responseMap = json.decode(response.body);
      if(responseMap.isNotEmpty){
        List<dynamic> admins = responseMap['admins'];
        return admins; 
      }else{
        return [];
      }
    }catch(e){
      print('Error: '+e.toString());
      return [];
    }
  }

  Future<Map> createAdmin(
    String name, String username, String email, 
    String password, String street, String number, String place
  ) async{

    Set<String> address = {
      'street', street,
      'number', number,
      'place',place
    };
    
    try{
      Response response = await post(
        Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/admin/createAdmin'),
        body: {
          'name': name,
          'username': username,
          'email': email,
          'password': password,
          'address': address
        }
      );

      Map responseMap = json.decode(response.body);
      return responseMap;

    }catch(e){
      print('Error: '+e.toString());
      return {};
    }
  }

  Future<Map> editAdmin(
    String id, String name, String username, String email, 
    String password, String street, String number, String place
  ) async{

    Set<String> address = {
      'street', street,
      'number', number,
      'place',place
    };

    try{
      Response response = await put(
        Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/admin/updateAdmin'),
        body: {
          'id': id,
          'name': name,
          'username': username,
          'email': email,
          'password': password,
          'address': address
        }
      );

      Map responseMap = json.decode(response.body);
      return responseMap;
    }catch(err){
      print('ERROR: $err');
      return {};
    }
  }

  Future<Map> deleteAdmin(String id) async {
    try{
      Response response = await delete(Uri.parse('${dotenv.get('NGROK_URL', fallback: '')}/admin/deleteAdmin/$id'));
      Map responseMap = json.decode(response.body);
      return responseMap;
    }catch(err){
      print('ERROR $err');
      return {};
    }
  }

}

final adminProvider = AdminProvider();