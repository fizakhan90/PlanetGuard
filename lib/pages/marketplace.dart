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
              size: 48.0, // Adjust the size as needed
              color: Colors.green, // Adjust the color as needed
            ),
            SizedBox(height: 16.0), // Add some spacing
            Text(
              "Coming Soon!",
              style: TextStyle(
                fontSize: 24.0, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
