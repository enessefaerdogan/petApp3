// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
    String id;
    String newsDate;
    int newsIndex;
    String newsOwner;
    String newsParagraf1;
    String newsParagraf2;
    String newsParagraf3;
    String newsPhoto;
    String newsTime;
    String newsTitle;

    News({
        required this.id,
        required this.newsDate,
        required this.newsIndex,
        required this.newsOwner,
        required this.newsParagraf1,
        required this.newsParagraf2,
        required this.newsParagraf3,
        required this.newsPhoto,
        required this.newsTime,
        required this.newsTitle,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        newsDate: json["news_date"],
        newsIndex: json["news_index"],
        newsOwner: json["news_owner"],
        newsParagraf1: json["news_paragraf1"],
        newsParagraf2: json["news_paragraf2"],
        newsParagraf3: json["news_paragraf3"],
        newsPhoto: json["news_photo"],
        newsTime: json["news_time"],
        newsTitle: json["news_title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "news_date": newsDate,
        "news_index": newsIndex,
        "news_owner": newsOwner,
        "news_paragraf1": newsParagraf1,
        "news_paragraf2": newsParagraf2,
        "news_paragraf3": newsParagraf3,
        "news_photo": newsPhoto,
        "news_time": newsTime,
        "news_title": newsTitle,
    };
}
