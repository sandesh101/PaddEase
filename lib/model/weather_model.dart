class WeatherModel {
  List<Weather>? weather;
  Main? main;
  String? name;
  // double? temp;

  WeatherModel({this.weather, this.main, this.name});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    name = json['name'];
    // temp = json["main"]["temp"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }
    if (this.main != null) {
      data['main'] = this.main!.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}

class Weather {
  String? description;
  String? icon;

  Weather({this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    description = json['main'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Main {
  double? temp;

  Main({this.temp});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    return data;
  }
}
