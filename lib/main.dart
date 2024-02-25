import 'dart:async';

import 'package:flutter/material.dart';
import 'package:planet_guard/pages/homepage.dart';
import 'package:planet_guard/pages/login.dart';
import 'package:planet_guard/pages/marketplace.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute : '/splash',
      routes: {
        '/splash' : (context) => Splash(),
        '/login' : (context) => LoginPage(),
        '/home'  : (context) => HomePage(),
        '/profile' : (context) => UserProfile(),
        '/marketplace' : (context) => Marketplace(),

      },
      );
      }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
   @override 
  void initState() { 
    super.initState(); 
  
    Timer( 
      const Duration(seconds: 4), 
      () =>Navigator.pushNamed( 
        context, '/login'),
      );  
  } 


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Image.asset(
          'assets/PlanetGaurd.png',
          width : 300,
          height : 300,
        ),
      ),
    );
  }
}

