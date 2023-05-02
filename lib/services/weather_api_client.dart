import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paddy_disease/model/weather_model.dart';

class WeatherApiClient {
  Future<WeatherModel>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=2edc332607c4cf946ead62a6aee4dae7");

    // var url = Uri.parse(
    //     "http://api.weatherapi.com/v1/current.json?key=c8ca22fba0e84f98bb5155001230205 &q=$location&aqi=no");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    // print("Weather: ${body}");
    return WeatherModel.fromJson(body);
  }
}
