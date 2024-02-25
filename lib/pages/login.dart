import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 119, 221, 119),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:24.0),
          child: Column(
            mainAxisAlignment : MainAxisAlignment.center,
            children: [ const Text(
              'BE A GAURDIAN OF THE PLANET!',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255,0,20,13),
                fontWeight: FontWeight.bold,
              ),),
            const SizedBox(height : 56),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                filled: true,
                fillColor : Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                prefixIcon: const Icon(Icons.account_circle_outlined),
                labelText: 'Enter your email',
                ),
            ),
            const SizedBox(height: 56),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                prefixIcon: const Icon(Icons.lock),
                labelText: 'Enter your password',
              ),
            ),
            const SizedBox(height: 56),
            ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/home');}, 
            child: const Text("Login"))
            ]
          ),
        )
      ),
    );
  }
}