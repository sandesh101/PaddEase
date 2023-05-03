import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paddy_disease/constants/constant.dart';
import 'package:paddy_disease/screens/home_page.dart';

import 'home_page_changed.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // final bytes = base64Decode(image);
  late String imagePath;
  late String disease;
  late String recommendation;

  //List of values to show the recommendation to certain disease
  Map<String, String> cureRecommendation = {
    'Brown Spot':
        'Use fungicides (e.g., iprodione, propiconazole, azoxystrobin, trifloxystrobin, and carbendazim) as seed treatments',
    'Leaf Blight':
        'Spray Streptomycin sulphate + Tetracycline combination 300 g + Copper oxychloride 1.25kg/ha',
    'Tungro': 'Once affected by TUNGRO it cannot be cured',
    'Healthy':
        'Although your plant is currently flourishing, you should be ready for the future.'
  };

  //Init state to call or get the arguments passed from the home page
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final args = Get.arguments;
    // print(args);
    imagePath = args['image'];
    disease = args['predicted_class'];
    returnRecommendation();
    print(recommendation);
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

  String returnRecommendation() {
    if (disease == "Brown Spot") {
      recommendation = cureRecommendation["Brown Spot"]!;
    } else if (disease == "Leaf Blight") {
      recommendation = cureRecommendation["Leaf Blight"]!;
    } else if (disease == "Tungro") {
      recommendation = cureRecommendation["Tungro"]!;
    } else {
      recommendation = cureRecommendation["Healthy"]!;
    }
    return recommendation;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Constant.primaryColor,
          appBar: AppBar(
            backgroundColor: Constant.primaryColor,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: IconButton(
                  onPressed: () {
                    // print("object");
                    Get.to(() => const NewHomePage());
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Constant.thirdColor,
                  )),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // IconButton(
                //     onPressed: () {
                //       Get.to(() => const HomePage());
                //     },
                //     icon: const Icon(
                //       Icons.home,
                //       color: Colors.white,
                //     )),
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
                const SizedBox(
                  height: 30,
                ),
                disease == "Healthy"
                    ? Text(
                        "Your Plant is HEALTHY.",
                        style: GoogleFonts.poppins(
                            color: Constant.secondaryColor, fontSize: 20),
                      )
                    // : Text(
                    //     "Your plant have ${disease.toUpperCase()} disease.",
                    //     // "Your plant have THIS Disease",
                    //     style: GoogleFonts.poppins(
                    //         color: Constant.secondaryColor, fontSize: 20),
                    //   ),
                    : RichText(
                        text: TextSpan(
                          text: 'Your plant have ',
                          style: GoogleFonts.poppins(
                              color: Constant.secondaryColor, fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                              text: disease.toUpperCase(),
                              style: GoogleFonts.poppins(
                                color: Constant.thirdColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: " disease.",
                              style: GoogleFonts.poppins(
                                  color: Constant.secondaryColor, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Probable Cure for the disease: ",
                  style: GoogleFonts.poppins(
                    color: Constant.thirdColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Constant.secondaryColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Text(
                        recommendation,
                        style: GoogleFonts.poppins(
                            color: Constant.textColor, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
