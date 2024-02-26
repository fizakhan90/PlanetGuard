import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:planet_guard/pages/registerpage.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:planet_guard/pages/homepage.dart';
import 'package:planet_guard/pages/login.dart';
import 'package:planet_guard/pages/marketplace.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/register' : (context) => RegisterPage(),

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
        context, '/register'),
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

