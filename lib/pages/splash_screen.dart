import 'package:flutter/material.dart';
import 'package:white_space/constants/articles_data.dart';
import 'package:white_space/models/article_models.dart';
import 'package:white_space/pages/feed_screens/home_page.dart';
import 'package:white_space/services/news.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    
  }

  @override
  void initState() {
    super.initState();
    getNews();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            "White Space",
            style: TextStyle(fontSize: 48),
          ),
        ),
      ),
    );
  }
}
