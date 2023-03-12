import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:raspcandy/pages/admin/admin_admin_list.dart';
import 'package:raspcandy/pages/admin/admin_home.dart';
import 'package:raspcandy/pages/admin/admin_profile.dart';
import 'package:raspcandy/pages/admin/admin_user_create.dart';
import 'package:raspcandy/pages/admin/admin_user_edit.dart';
import 'package:raspcandy/pages/admin/admin_user_list.dart';
import 'package:raspcandy/pages/admin/admin_user_profile.dart';
import 'package:raspcandy/pages/admin_login.dart';
import 'package:raspcandy/pages/candy/candy_home.dart';
import 'package:raspcandy/pages/user/user_edit.dart';
import 'package:raspcandy/pages/user/user_home.dart';
import 'package:raspcandy/pages/user/user_profile.dart';
import 'package:raspcandy/pages/user_login.dart';
import 'package:raspcandy/pages/user_register.dart';

import 'models/UserDataProvider.dart';
import 'models/AdministratorDataProvider.dart';

Future<void> main() async{
  await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
        ChangeNotifierProvider(create: (_) => AdministratorDataProvider())
      ],
      child: const MyApp(),
    )
  );
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
        'admin_admin_profile':(context) => const AdminProfile(), 
        'admin_user_list':(context) => const AdminUserList(),
        'admin_admin_list':(context) => const AdminAdminList(),
        'admin_user_profile':(context) => const AdminUserProfile(),
        'admin_user_create':(context) => const AdminUserCreate(),
        'admin_user_edit':(context) => const AdminUserEdit(),
        'candy_home':(context) => const CandyHome(),
      },

    );
  }
}