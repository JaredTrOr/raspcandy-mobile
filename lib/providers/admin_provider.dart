import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:raspcandy/models/user_list_provider.dart';

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

}

final adminProvider = AdminProvider();