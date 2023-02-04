import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                "Paddy Leaf Disease Detection",
                style: GoogleFonts.poppins(
                    color: const Color(0xFFF0BB62), fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
