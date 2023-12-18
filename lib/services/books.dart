import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:white_space/models/book_models.dart';

class Books {
  List<BookArticle> books = [];
  int total = 0;

  Future<List<BookArticle>> getBooks() async {

    String url ='https://api.nytimes.com/svc/books/v3/lists/current/advice-how-to-and-miscellaneous.json?api-key=';
    // Add API Key

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    total = jsonData['num_results'];
    if (jsonData['status'] == 'OK') {
      jsonData["results"]["books"].forEach((element) {
        if (element["book_image"] != null && element['amazon_product_url'] != null) {
          BookArticle articleModel = BookArticle(
            title: element["title"],
            description: element["description"],
            author: element["author"],
            imageUrl: element["book_image"],
            url : element["amazon_product_url"]
          );
          books.add(articleModel);
        }
      });
    }
    return books;
  }
}
