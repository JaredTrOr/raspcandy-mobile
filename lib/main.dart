import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:raspcandy/pages/admin/admin_home.dart';
import 'package:raspcandy/pages/admin_login.dart';
import 'package:raspcandy/pages/user/user_edit.dart';
import 'package:raspcandy/pages/user/user_home.dart';
import 'package:raspcandy/pages/user/user_profile.dart';
import 'package:raspcandy/pages/user_login.dart';
import 'package:raspcandy/pages/user_register.dart';

Future<void> main() async{
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raspcandy',
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'user_register',
      routes: {
        //Public pages
        'user_register':(context) => const UserRegister(),
        'user_login':(context) => const UserLogin(),
        'admin_login': (context) => const AdminLogin(),

        //User pages
        'user_home': (context) => const UserHome(),
        'user_profile':(context) => const UserProfile(),
        'user_edit':(context) => const UserEdit(),

        //Admin pages
        'admin_home':(context) => const AdminHome(),
      },

    );
  }
}