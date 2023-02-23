import 'package:flutter/material.dart';

import '../../models/UserData.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(user.getName()),
      ),
    );
  }
}