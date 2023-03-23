import 'package:flutter/material.dart';

class UserListProvider extends ChangeNotifier{
  
  List<dynamic>? _userListData;

  get getUserListData => _userListData;

  set setUserListData(List<dynamic> data){
    _userListData = data;
    notifyListeners();
  }

}

final userListProvider = UserListProvider();