import 'package:flutter/material.dart';

class Marketplace extends StatelessWidget {
  const Marketplace({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              size: 48.0, 
              color: Colors.green, 
            ),
            SizedBox(height: 16.0), 
            Text(
              "Coming Soon!",
              style: TextStyle(
                fontSize: 24.0, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
