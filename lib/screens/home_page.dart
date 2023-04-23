import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paddy_disease/constants/constant.dart';
import 'package:paddy_disease/screens/disease_screen.dart';
import 'package:paddy_disease/widgets/buttons.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPickedImage = false;
  XFile? pickedImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constant.primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: isPickedImage
                      ? Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Constant.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Image.file(
                              File(pickedImage!.path).absolute,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Text(
                              "Upload Picture of your paddy Leaf",
                              style: GoogleFonts.poppins(
                                  color: Constant.secondaryColor, fontSize: 20),
                            ),
                            Text(
                              "or Take Photo",
                              style: GoogleFonts.poppins(
                                  color: Constant.secondaryColor, fontSize: 20),
                            ),
                          ],
                        ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Buttons(
                  buttonText: "Upload Photo",
                  onPressed: pickImage,
                ),
                const SizedBox(
                  height: 20,
                ),
                Buttons(
                  buttonText: "Take Photo",
                  onPressed: takeImage,
                ),
                const SizedBox(
                  height: 40,
                ),
                isPickedImage
                    ? Buttons(
                        buttonText: "Submit Image",
                        onPressed: () async {
                          uploadImage();
                          // final bytes = await pickedImage!.readAsBytes();
                          // final base64Image = base64Encode(bytes);
                          final imagePath = pickedImage!.path;
                          print(imagePath);
                          Get.to(
                            () => const ResultScreen(),
                            arguments: {'image': imagePath},
                          );
                          setState(() {
                            isPickedImage = false;
                          });
                        })
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickImage() async {
    // print("Hello");
    pickedImage = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    setState(() {
      isPickedImage = true;
    });
    // print(pickedImage);
  }

  takeImage() async {
    // print("Hello");
    pickedImage = (await ImagePicker().pickImage(source: ImageSource.camera))!;
    // print(pickedImage.toString());
    setState(() {
      isPickedImage = true;
    });
  }

  uploadImage() async {
    // print("Hello");
    var stream = http.ByteStream(pickedImage!.openRead());
    stream.cast();

    var length = await pickedImage!.length();

    var uri = Uri.parse("https://fakestoreapi.com/products");

    var request = http.MultipartRequest("POST", uri);

    var multipart = http.MultipartFile("image", stream, length);

    request.files.add(multipart);

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      print(responseString);
      return responseString;
    } else {
      print("Failed to upload");
    }
  }
}
