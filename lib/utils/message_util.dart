import 'package:flutter/material.dart';
import '../widgets/alert_message.dart';

class AlertMessageUtil {
  String image = '';
  String title = 'llamen a Dios';
  String content = '';
  String color = '';

  void displayMessage(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertMessage(
          image: image,
          title: title,
          content: content,
          color: color
        );
      }
    );
  }

  void setAlertText(Map response) {
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
