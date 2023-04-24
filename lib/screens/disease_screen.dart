import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paddy_disease/constants/constant.dart';
import 'package:paddy_disease/screens/home_page.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // final bytes = base64Decode(image);
  late String imagePath;
  late String disease;

  //Init state to call or get the arguments passed from the home page
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final args = Get.arguments;
    // print(args);
    imagePath = args['image'];
    disease = args['predicted_class'];
    // getDiseaseName(); // Call the async function to retrieve the disease name.
    // print("Disease Screen: $imagePath");
    // print("Disease Screen: $disease");
    // print(disease.toUpperCase());
  }

  // Future<void> getDiseaseName() async {
  //   final diseaseName = await id; // Wait for the 'id' Future to resolve.
  //   setState(() {
  //     // this.diseaseName = diseaseName; // Set the disease name in the state.
  //   });
  // }

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Constant.primaryColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Get.to(() => const HomePage());
                  },
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                  )),
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Constant.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.file(
                    File(imagePath).absolute,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              disease == "Healthy"
                  ? Text(
                      "Your Plant is HEALTHY.",
                      style: GoogleFonts.poppins(
                          color: Constant.secondaryColor, fontSize: 20),
                    )
                  : Text(
                      "Your plant have ${disease.toUpperCase()} disease.",
                      // "Your plant have THIS Disease",
                      style: GoogleFonts.poppins(
                          color: Constant.secondaryColor, fontSize: 20),
                    ),
            ],
          )),
    );
  }
}
