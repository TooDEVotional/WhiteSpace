import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:white_space/main.dart';
import 'package:white_space/models/article_models.dart';

class News {
  List<NewsArticle> news = [];
  int total = 0;

  Future<List<NewsArticle>> getNews(int page) async {

    String url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=&pageSize=10&page=' +
            page.toString();
    // Add API Key

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          NewsArticle articleModel = NewsArticle(
            title: element["title"],
            description: element["description"],
            source: element["url"],
            imageUrl: element["urlToImage"],
            url : element["url"]
          );
          news.add(articleModel);
        }
      });
    }
    return news;
  }
}
