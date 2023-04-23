import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paddy_disease/constants/constant.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // final bytes = base64Decode(image);
  late Map<String, String> imagePath;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePath = Get.arguments;
    print(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.primaryColor,
      body: Container(
        child: Image.file(
          File(imagePath as String),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
