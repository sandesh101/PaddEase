import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF064635),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Image.asset('assets/SplashScreen.png'),
            ),
            const Text(
              "Paddy Leaf Disease Detection System",
              style: TextStyle(color: Color(0xFFF0BB62)),
            ),
          ],
        ),
      ),
    );
  }
}
