import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(200, 255, 255, 255), Color.fromARGB(200, 121, 159, 12)]
          )
        ),
      
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:24.0),
          child: Column(
            
            mainAxisAlignment : MainAxisAlignment.center,
            children: [
              const SizedBox(height: 0),
              const Text(
              'BE A GUARDIAN OF THE PLANET!',
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 30, 50, 30),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height : 80),
            SizedBox(
              height: 70,
              child: TextField(
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
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 70,
              child: TextField(
                
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
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 100,
              child: ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/home');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 30 , 50, 30)),
              ), 
              child: const Text("Login",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 250, 250, 250 )
              ),)),
            ),
            const SizedBox(height: 130)
            ]
          ),
        )
      ),
    ),
    );
  }
}