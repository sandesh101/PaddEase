import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:paddy_disease/constants/constant.dart';

class Buttons extends StatefulWidget {
  final String buttonText;
  final Function onPressed;
  Buttons({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Constant.secondaryColor,
      ),
      onPressed: () {
        widget.onPressed();
      },
      child: Text(
        widget.buttonText,
        style: GoogleFonts.poppins(
          color: Constant.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
