import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paddy_disease/model/news_model.dart';
import 'package:paddy_disease/model/weather_model.dart';
import 'package:paddy_disease/screens/home_page.dart';
import 'package:paddy_disease/screens/news_screen.dart';
import 'package:paddy_disease/services/news_api_client.dart';
import 'package:paddy_disease/services/weather_api_client.dart';
import 'package:paddy_disease/widgets/buttons.dart';

import '../constants/constant.dart';
import 'package:intl/intl.dart';

// GoogleFonts.poppins(
//                                   color: Constant.secondaryColor, fontSize: 20),
class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  String? dateStr;
  String? monthName;
  WeatherApiClient weatherApiClient = WeatherApiClient();
  NewsApiClient newsApiClient = NewsApiClient();
  WeatherModel? data;
  NewsModel? newsData;
  double tempinK = 0.0;
  double? tempinC;
  String? imgUrl = "false";

  @override
  void initState() {
    super.initState();
    getDate();
    // weatherApiClient.getCurrentWeather("Kathamandu");
    getNews();
  }

  Future<void> getWeather() async {
    data = await weatherApiClient.getCurrentWeather("Kathmandu");
    tempinK = data!.main!.temp!;
    tempinC = (tempinK - 273.15);
  }

  Future<void> getNews() async {
    newsData = await newsApiClient.getNews();

    // print(newsData);
  }

  void getDate() {
    DateTime now = DateTime.now();
    dateStr = "${now.day}";
    monthName = DateFormat('MMM').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Constant.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Weather Report
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 10.0),
            child: Text(
              "Weather Report",
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  color: Constant.whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: getWeather(),
              builder: (context, snapshot) {
                // print(snapshot);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Constant.thirdColor,
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Constant.thirdColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //Weather Texts
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data!.name}, $monthName $dateStr",
                              style: GoogleFonts.poppins(
                                  color: Constant.blackColor, fontSize: 20),
                            ),
                            Text(
                              "${tempinC?.toStringAsFixed(2)}°C",
                              style: GoogleFonts.poppins(
                                  color: Constant.blackColor, fontSize: 30),
                            ),
                            Text(
                              "${data!.weather![0].description}",
                              style: GoogleFonts.poppins(
                                  color: Constant.blackColor, fontSize: 20),
                            ),
                          ],
                        ),
                        //Weather Icon Image
                        Image(
                          image: NetworkImage(
                            "https://openweathermap.org/img/w/${data!.weather![0].icon}.png",
                            scale: 0.5,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          //Weather Report Ends
          //Services
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 10.0),
            child: Text(
              "Services",
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  color: Constant.whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Constant.containerColor,
                boxShadow: [
                  BoxShadow(
                    color: Constant.blackColor.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(4, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 50.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const HomePage());
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              color: Constant.primaryColor,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Image(
                                image: AssetImage(
                                    'assets/images/DetectDisease.png')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "Detect Disease",
                          style: GoogleFonts.poppins(
                              color: Constant.whiteColor, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 50.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                            color: Constant.primaryColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Image(
                              image: AssetImage('assets/images/NewsImage.png')),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 55.0),
                        child: Text(
                          "News",
                          style: GoogleFonts.poppins(
                              color: Constant.whiteColor, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Services Ends
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Trending News",
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                    color: Constant.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Buttons(
                  buttonText: "See All News",
                  onPressed: () {
                    Get.to(() => const NewsScreen());
                  }),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          //NEWS API
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: getNews(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Constant.thirdColor,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          if (newsData!.results![index].imageUrl == null) {
                            imgUrl =
                                "https://cdn-icons-png.flaticon.com/512/190/190738.png?w=740&t=st=1683227526~exp=1683228126~hmac=ecea5efafa09df583579c6f60495572a3812084d8a5e860c715751bf1d191bf6";
                          } else {
                            imgUrl = newsData!.results![index].imageUrl;
                          }
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Constant.containerColor,
                              ),
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceAround,
                                children: [
                                  //Weather Texts
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${newsData!.results![index].title}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: GoogleFonts.poppins(
                                              color: Constant.blackColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${newsData!.results![index].description}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                              color: Constant.whiteColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //NEWS Image
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 8.0),
                                    child: Image(
                                      height: 130,
                                      width: 150,
                                      image: NetworkImage("$imgUrl"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    ));
  }
}
