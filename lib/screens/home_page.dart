import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paddy_disease/constants/constant.dart';
import 'package:paddy_disease/widgets/buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constant.primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: Column(
              children: [
                Text(
                  "Upload Picture of your paddy Leaf",
                  style: GoogleFonts.poppins(
                      color: Constant.secondaryColor, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: Buttons(
                    buttonText: "Upload Photo",
                    onPressed: pickImage,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

pickImage() async {
  // print("Hello");
  final XFile? pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  print(pickedImage);
}
