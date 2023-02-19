import 'package:flutter/material.dart';
import 'package:raspcandy/widgets/logo.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Logo()
      ),
    );
  }


}