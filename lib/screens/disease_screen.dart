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
  late int id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final args = Get.arguments;
    print(args);
    imagePath = args['image'];
    id = args['id'];
    // getDiseaseName(); // Call the async function to retrieve the disease name.
    print("Disease Screen: $imagePath");
    print("Disease Screen: $id");
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
                    Get.to(() => HomePage());
                  },
                  icon: Icon(Icons.home)),
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
              Text(
                "Your plant with id = $id have THIS Disease",
                // "Your plant have THIS Disease",
                style: GoogleFonts.poppins(
                    color: Constant.secondaryColor, fontSize: 20),
              ),
            ],
          )),
    );
  }
}
