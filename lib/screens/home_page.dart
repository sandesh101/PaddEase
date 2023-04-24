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
import 'package:path/path.dart';

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
                          // uploadImage();
                          final String? diseaseName = await uploadImage();
                          final imagePath = pickedImage!.path;
                          // print(imagePath);
                          // print("Uploaded Image: $id");
                          Get.to(
                            () => const ResultScreen(),
                            arguments: {
                              'image': imagePath,
                              'predicted_class': diseaseName,
                            },
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

  //Method to pick image from the gallery
  pickImage() async {
    // print("Hello");
    pickedImage = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    setState(() {
      isPickedImage = true;
    });
    // print(pickedImage);
  }

  //Method to take photo using camera
  takeImage() async {
    // print("Hello");
    pickedImage = (await ImagePicker().pickImage(source: ImageSource.camera))!;
    // print(pickedImage.toString());
    setState(() {
      isPickedImage = true;
    });
  }

  // uploadImage() async {
  //   var stream = http.ByteStream(pickedImage!.openRead());
  //   stream.cast();

  //   var length = await pickedImage!.length();

  //   var uri = Uri.parse("https://fakestoreapi.com/products");

  //   var request = http.MultipartRequest("POST", uri);

  //   var multipart = http.MultipartFile("image", stream, length);

  //   request.files.add(multipart);

  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     final responseData = await response.stream.toBytes();
  //     final responseString = String.fromCharCodes(responseData);
  //     print("Value: $responseString");
  //     return responseString;
  //   } else {
  //     print("Failed to upload");
  //   }
  // }

  // Future<int?> uploadImage() async {
  //   var stream = http.ByteStream(pickedImage!.openRead());
  //   stream.cast();

  //   var length = await pickedImage!.length();
  //   String url = "http://192.168.146.199:5500/predict";

  //   var uri = Uri.parse(url);

  //   var request = http.MultipartRequest("POST", uri);

  //   var multipart = http.MultipartFile("file", stream, length);

  //   request.files.add(multipart);

  //   var response = await request.send();
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     final responseData = await response.stream.toBytes();
  //     final responseString = String.fromCharCodes(responseData);
  //     final responseMap = jsonDecode(responseString) as Map<String, dynamic>;
  //     print(responseMap);
  //     // final id = responseMap['id'] as int?;
  //     // print("id: $id");
  //     // return id;
  //   } else {
  //     print("Failed to upload");
  //     return null;
  //   }
  // }

  //Method to pass image to server and get the disease
  Future<String?> uploadImage() async {
    var stream = http.ByteStream(pickedImage!.openRead());
    stream.cast();

    var length = await pickedImage!.length();
    //Server URL
    String url = "http://192.168.171.199:5500/predict";

    var uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri);

    var multipart = http.MultipartFile("file", stream, length,
        filename: basename(pickedImage!.path));

    request.files.add(multipart);

    request.headers.addAll({"Content-Type": "multipart/form-data"});

    //Response
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final responseMap = jsonDecode(responseString) as Map<String, dynamic>;
      print(responseMap);
      final disease = responseMap['predicted_class'];
      // print("Disease: $disease");
      return disease;
    } else {
      print("Failed to upload");
      return null;
    }
  }
}
