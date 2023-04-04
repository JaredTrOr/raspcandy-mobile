import 'package:flutter/material.dart';
import '../widgets/alert_message.dart';

class AlertMessageUtil {
  String image = '';
  String title = '';
  String content = '';
  String color = '';
  Map? response; //Set response (still in check)

  void displayMessage(BuildContext context, Function() redirect) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertMessage(
          image: image,
          title: title,
          content: content,
          color: color,
          redirect: redirect,
        );
      }
    );
  }

  set setResponse(Map response){
    this.response = response;
  }

  set setAlertText(Map response) {
    if (response.isNotEmpty) {
      if (response['success']) {
        image = 'success';
        title = 'Operación exitosa';
        color = 'green';
      } else {
        image = 'alert';
        title = 'Alerta';
        color = 'orange';
      }

      print(response['msg']);
      content = response['msg'];
    } else {
      image = 'error';
      title = 'Error';
      color = 'red';
      content = 'Hubo un error en la operación';
    }

    
  }
}

final alertMessage = AlertMessageUtil();
