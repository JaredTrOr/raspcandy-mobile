import 'package:flutter/material.dart';
import 'package:raspcandy/widgets/logo.dart';

import '../widgets/candy_dispenser.dart';
import '../widgets/container.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                //Logo
                const SizedBox(height: 30),
                const Logo(),
                const SizedBox(height: 20),
                const CandyDispenserImage(width: 130),
                const SizedBox(height: 30),
                MainContainer(child: _loginForm()),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginForm(){ 

  }
}