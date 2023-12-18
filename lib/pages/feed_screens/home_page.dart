import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:white_space/components/feed_card.dart';
import 'package:white_space/constants/articles_data.dart';
import 'package:white_space/models/article_models.dart';
import 'package:white_space/pages/feed_screens/feed_page.dart';
import 'package:white_space/pages/feed_screens/view_page.dart';
import 'package:white_space/services/news.dart';
import 'package:white_space/services/quotes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List quoteNew = ['loading', 'loading'];
  final _scrollController = ScrollController();
  int total = 0;
  int page = 1;
  List<NewsArticle>? _articles = [
    const NewsArticle(
      title: 'Loading',
      description: 'Loading',
      source: 'Loading',
      imageUrl: 'https://retchhh.files.wordpress.com/2015/03/loading1.gif',
      url: '',
    )
  ];
  var newsHandler = News();
  var quoteHandler = Quote();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
    initNews();
    initQuote();
  }

  Future<void> initQuote() async {
    var data = await quoteHandler.getQuote();
    setState(() {
      quoteNew = data;
    });
    print(data);
  }

  Future<void> initNews() async {
    var data = await newsHandler.getNews(page);
    setState(() {
      if (page == 1) {
        _articles = data;
      } else {
        _articles = _articles! + data;
      }

      total = newsHandler.total;
    });
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        page++;
        initNews();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                      child: GestureDetector(
                        child: Text(
                          'Read',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        onTap: () => {
                          Navigator.of(context).pushReplacementNamed('/home')
                        },
                      ),
                    ),
                    const Gap(8),
                    GestureDetector(
                      child: Text('Reflect',
                          style: Theme.of(context).textTheme.displaySmall),
                      onTap: () => {
                        Navigator.of(context).pushReplacementNamed('/reflect')
                      },
                    ),
                    const Gap(8),
                    GestureDetector(
                      child: Text(
                        'Experiment',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      onTap: () => {
                        Navigator.of(context).pushReplacementNamed('/experiment')
                      },
                    ),
                    const Gap(32),
                    Container(
                      width: width - 112,
                      child: Text(
                        quoteNew[0],
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
                    Text("-" + quoteNew[1],
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
                          Navigator.of(context).pushReplacementNamed('/feed');
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: 48,
                          color: Theme.of(context).secondaryHeaderColor,
                        )),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Text(
                              "Top Picks",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            onTap: () => {
                              Navigator.of(context)
                                  .pushReplacementNamed('/feed')
                            },
                          ),
                          const Gap(16),
                          GestureDetector(
                            child: Text(
                              "Books",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            onTap: () => {
                              Navigator.of(context)
                                  .pushReplacementNamed('/books')
                            },
                          ),
                          const Gap(16),
                          GestureDetector(
                            child: Text(
                              "Latest",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            onTap: () => {
                              Navigator.of(context)
                                  .pushReplacementNamed('/latest')
                            },
                          )
                        ],
                      ),
                    ),

                    //Add ListView here with Cards.
                    Container(
                      height: 360,
                      width: width - 56,
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: _articles?.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewPage(
                                            url: _articles![index].url)))
                              },
                              child: FeedCard(
                                newheight: newheight,
                                width: width,
                                title: _articles![index].title,
                                description: _articles![index].description,
                                image: _articles![index].imageUrl,
                              ),
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
