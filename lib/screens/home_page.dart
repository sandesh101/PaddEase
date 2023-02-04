import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paddy_disease/constants/constant.dart';
import 'package:paddy_disease/widgets/buttons.dart';
import 'package:cross_file_image/cross_file_image.dart';

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
                            child: Image(image: XFileImage(pickedImage!)),
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
                        onPressed: () {
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
}
