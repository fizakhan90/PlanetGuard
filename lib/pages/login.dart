import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment : MainAxisAlignment.center,
          children: [ Text("Login"),
          SizedBox(height : 56),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor : Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              labelText: 'Enter your email',
              ),
          ),
          SizedBox(height: 56),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              labelText: 'Enter your password',
            ),
          ),
          SizedBox(height: 56),
          ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/home');}, 
          child: Text("Login"))
          ]
        )
      ),
    );
  }
}