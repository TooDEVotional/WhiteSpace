import 'dart:convert';
import 'package:http/http.dart' as http;

class Quote {

  Future<List> getQuote() async {
    String url =
        'https://api.api-ninjas.com/v1/quotes?category=success'; // Add API Key
        

    var response = await http.get(Uri.parse(url), headers: {
      'X-Api-Key' : ''
    });

    var jsonData = jsonDecode(response.body);

    return  [jsonData[0]["quote"],jsonData[0]["author"]];
  }
}
