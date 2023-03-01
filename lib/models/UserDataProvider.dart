import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier{

  //ATTRIBUTES
  String _id = '';
  String _name = '';
  String _username = '';
  String _password = '';
  String _email = '';

  //STANDBY
  /*
  String purchases= '';
  String amountOfPurchases = '';
  String favoriteCandy = '';
  */

  //METHODS
  void setData(String id, String name,String username, String password, String email){
    _id = id;
    _name = name;
    _username = username;
    _password = password;
    _email = email;
    notifyListeners();
  }

  void updateData(String name, String username, String password, String email){
    _name = name;
    _username = username;
    _password = password;
    _email = email;
    notifyListeners();
  }

  void deleteData(){
    _id = '';
    _name = '';
    _username = '';
    _password = '';
    _email = '';
    notifyListeners();
  }

  //SETTERS
  set setName(String name){
    _name = name;
    notifyListeners();
  }

  set setUsername(String username){
    _username = username;
    notifyListeners();
  }

  set setPassword(String password){
    _password = password;
    notifyListeners();
  }

  set setEmail(String email){
    _email = email;
    notifyListeners();
  }
  
  //GETTERS
  String get getName => _name;
  String get getUsername => _username;
  String get getPassword => _password;
  String get getEmail => _email;
  String get getId => _id;
}