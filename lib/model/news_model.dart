class NewsModel {
  List<Results>? results;

  NewsModel({this.results});

  NewsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? title;
  String? link;
  String? description;
  String? content;
  String? pubDate;
  String? imageUrl;
  String? sourceId;

  Results(
      {this.title,
      this.link,
      this.description,
      this.content,
      this.pubDate,
      this.imageUrl,
      this.sourceId});

  Results.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    description = json['description'];
    content = json['content'];
    pubDate = json['pubDate'];
    imageUrl = json['image_url'];
    sourceId = json['source_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    data['description'] = this.description;
    data['content'] = this.content;
    data['pubDate'] = this.pubDate;
    data['image_url'] = this.imageUrl;
    data['source_id'] = this.sourceId;
    return data;
  }
}
