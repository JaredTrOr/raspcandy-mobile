import 'package:flutter/material.dart';

class AdministratorDataProvider extends ChangeNotifier{

  //ATTRIBUTES
  String _id = '';
  String _name = '';
  String _username = '';
  String _password = '';
  String _email = '';

  //Admin Address
  String _street = '';
  String _number = '';
  String _place = '';

  void setData(
    String id, String name, String username, String password, String email,
    String street, String number, String place
  ){
    _id = id;
    _name = name;
    _username = username;
    _password = password;
    _email = email;
    _street = street;
    _number = number;
    _place = place;
    notifyListeners();
  }

  void updateData(
    String name, String username, String password, 
    String email, String street, String number, String place
  ){
    _name = name;
    _username = username;
    _password = password;
    _email = email;
    _street = street;
    _number = number;
    _place = place;
    notifyListeners();
  }

  void resetData(){
    _id = '';
    _name = '';
    _username = '';
    _password = '';
    _email = '';
    _street = '';
    _number = '';
    _place = '';
    notifyListeners();
  }

  String get getId => _id;
  String get getName => _name;
  String get getUsername => _username;
  String get getPassword => _password;
  String get getEmail => _email;
  String get getStreet => _street;
  String get getNumber => _number;
  String get getPlace => _place;
}