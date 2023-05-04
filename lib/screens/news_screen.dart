import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constant.dart';
import '../model/news_model.dart';
import '../services/news_api_client.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsModel? newsData;
  NewsApiClient newsApiClient = NewsApiClient();
  String? imgUrl = "";
  Future<void> getNews() async {
    newsData = await newsApiClient.getNews();

    // print(newsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Constant.blackColor),
        backgroundColor: Constant.thirdColor,
        elevation: 0.0,
        title: Text(
          "Recent NEWS",
          style: GoogleFonts.poppins(
              color: Constant.blackColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Constant.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: getNews(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return SizedBox(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        if (newsData!.results![index].imageUrl == null) {
                          imgUrl =
                              "https://cdn-icons-png.flaticon.com/512/190/190738.png?w=740&t=st=1683227526~exp=1683228126~hmac=ecea5efafa09df583579c6f60495572a3812084d8a5e860c715751bf1d191bf6";
                        } else {
                          imgUrl = newsData!.results![index].imageUrl;
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: GestureDetector(
                            onTap: () async {
                              // print("Clicked");
                              final url = Uri.parse(
                                  "${newsData!.results![index].link}");
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Constant.containerColor,
                              ),
                              child: Row(
                                children: [
                                  //Weather Texts
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            "${newsData!.results![index].content}",
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
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
