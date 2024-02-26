import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _userExists = false;

  Future<void> _registerWithEmailAndPassword(BuildContext context) async {
    try {
      if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter both email and password.'),
          ),
        );
        return;
      }

      // Try to create a new user with the given email and password
      var userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // After successful registration, navigate to the homepage
      if (userCredential.user != null) {
        Navigator.pushReplacementNamed(context, '/home');
        return;
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        String errorMessage = 'An error occurred, please try again.';
        if (e.code == 'email-already-in-use') {
          errorMessage = 'User already exists. Please log in.';
          Navigator.pushReplacementNamed(context, '/login');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      } else {
        print('Unexpected error during registration: $e');
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
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(height: 80),
                SizedBox(
                  height: 70,
                  child: TextField(
                    controller: _emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      prefixIcon: const Icon(Icons.account_circle_outlined),
                      labelText: 'Enter your email',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_userExists)
                  Text(
                    'User already exists. Please log in.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _registerWithEmailAndPassword(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 30, 50, 30)),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 250, 250, 250),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
