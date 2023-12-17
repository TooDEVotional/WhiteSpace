import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:white_space/components/feed_card.dart';
import 'package:white_space/constants/articles_data.dart';
import 'package:white_space/models/article_models.dart';
import 'package:white_space/pages/feed_screens/home_page.dart';
import 'package:white_space/services/news.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
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

    double height = MediaQuery.of(context).size.height;

    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;

    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            height: newheight,
            width: width,
            color: Theme.of(context).primaryColor,
          ),
          Column(
            children: [
              Gap(16),
              Hero(
                tag: "title",
                child: Text(
                  'Read',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Gap(16),
              Expanded(
                child: Hero(
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
                                  builder: (context) => HomeScreen()));
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
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
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              const Gap(16),
                              Text(
                                "Books",
                                style: Theme.of(context).textTheme.labelSmall,
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
                        Expanded(
                          child: Container(
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
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
