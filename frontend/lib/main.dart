import 'package:flutter/material.dart';
import 'package:frontend/home/home_page.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hotel ',
        theme: ThemeData(
            primarySwatch: Colors.blueGrey
        ),
        debugShowCheckedModeBanner: false,
        routes:{
          '/': (context) => LoginPage(),
          '/home': (context) => Home(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
        }

    );
  }
}