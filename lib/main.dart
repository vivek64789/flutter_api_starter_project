import 'package:flutter/material.dart';
import 'package:project_api/screen/login_screen.dart';
import 'package:project_api/screen/register_screen.dart';
import 'package:project_api/screen/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
      },
      home: SafeArea(
        child: LoginScreen(),
      ),
    );
  }
}
