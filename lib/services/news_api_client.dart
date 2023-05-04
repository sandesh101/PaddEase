import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paddy_disease/model/news_model.dart';

class NewsApiClient {
  // final data;
  var data;
  Future<NewsModel>? getNews() async {
    //If only agriculture
    // var endpoint = Uri.parse(
    //     "https://newsdata.io/api/1/news?country=np&apikey=pub_21653332d8f7ea0fbce7ceba71988ac0cf1fd&q=agriculture");

    //If Whole
    var endpoint = Uri.parse(
        "https://newsdata.io/api/1/news?country=np&apikey=pub_21653332d8f7ea0fbce7ceba71988ac0cf1fd");
    var response = await http.get(endpoint);
    if (response.statusCode == 200) {
      data = json.decode(utf8.decode(response.bodyBytes));
    }
    // var body = jsonDecode(response.body);
    // print("NEWS: ${data}");
    return NewsModel.fromJson(data);
  }
}
