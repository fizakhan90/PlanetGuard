import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Future<void> _loginWithEmailAndPassword(BuildContext context) async {
  try {
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both email and password.'),
        ),
      );
      return;
    }

    // Sign in with email and password
    await _auth.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    Navigator.pushReplacementNamed(context, '/home');
  } catch (e) {
    if (e is FirebaseAuthException) {
      String errorMessage = 'An error occurred, please try again.';
      if (e.code == 'user-not-found') {
        errorMessage = 'User not found. Please check your email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Invalid password. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    } else {
      print('Unexpected error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An unexpected error occurred.'),
        ),
      );
    }
  }
}

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
                controller: _emailController,
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
                controller: _passwordController,
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
              child: ElevatedButton(
               onPressed: () async {
                await _loginWithEmailAndPassword(context);
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

