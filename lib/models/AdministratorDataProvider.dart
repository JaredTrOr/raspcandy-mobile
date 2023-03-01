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

  String getId() => _id;
  String getName() => _name;
  String getUsername() => _username;
  String getPassword() => _password;
  String getEmail() => _email;
  String getStreet() => _street;
  String getNumber() => _number;
  String getPlace() => _place;
}