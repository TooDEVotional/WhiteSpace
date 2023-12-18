import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:white_space/components/feed_card.dart';
import 'package:white_space/constants/articles_data.dart';
import 'package:white_space/models/article_models.dart';
import 'package:white_space/pages/feed_screens/experiment_page.dart';
import 'package:white_space/pages/feed_screens/feed_page.dart';
import 'package:white_space/pages/feed_screens/reflect_page.dart';
import 'package:white_space/pages/onboarding_screens/read_onb_page.dart';
import 'package:white_space/services/news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<NewsArticle>? _articles;

  @override
  void initState() {
    super.initState();
    getNews();
    // Fetch articles on widget initialization
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    _articles = newsClass.news;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    double height = MediaQuery.of(context).size.height;
    print(height);
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: newheight * 0.4,
              width: width,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "title",
                      child: Text(
                        'Read',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    const Gap(8),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReflectScreen()));
                      },
                      child: Text('Reflect',
                          style: Theme.of(context).textTheme.displaySmall),
                    ),
                    const Gap(8),
                    GestureDetector(
                      onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ExperimentScreen()));
                  },
                      child: Text(
                        'Experiment',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    const Gap(32),
                    Container(
                      width: width - 112,
                      child: Text(
                        "Don't let yourself make excuses for not doing the things you want to do.",
                        maxLines: 4,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF1E1E1E).withOpacity(0.6),
                        ),
                      ),
                    ),
                    const Gap(8),
                    Text("-Sam Altman",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF1E1E1E).withOpacity(0.6),
                        ))
                  ],
                ),
              ),
            ),
            Hero(
              tag: "FeedWidget",
              child: Container(
                height: newheight * 0.6,
                width: width,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)),
                  border: Border.all(
                    color: const Color(0xFF1E1E1E).withOpacity(0.4),
                  ),
                ),
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FeedPage()));
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: 48,
                          color: Theme.of(context).secondaryHeaderColor,
                        )),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 96, 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Top Picks",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const Gap(16),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      SecondOnboardingPage()));
                            },
                            child: Text(
                              "Books",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                          const Gap(16),
                          Text(
                            "Latest",
                            style: Theme.of(context).textTheme.labelSmall,
                          )
                        ],
                      ),
                    ),

                    //Add ListView here with Cards.
                    Container(
                      height: 360,
                      width: width - 56,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: articles?.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: FeedCard(
                              newheight: newheight,
                              width: width,
                              title: articles![index].title,
                              description: articles![index].description,
                              image: articles![index].imageUrl,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// padding: const EdgeInsets.fromLTRB(0, 24, 8, 0),