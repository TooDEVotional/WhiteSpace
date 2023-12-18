import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:white_space/components/feed_card.dart';
import 'package:white_space/constants/articles_data.dart';
import 'package:white_space/models/article_models.dart';
import 'package:white_space/pages/feed_screens/home_page.dart';
import 'package:white_space/pages/feed_screens/view_page.dart';
import 'package:white_space/services/latest.dart';

class LatestPage extends StatefulWidget {
  const LatestPage({super.key});

  @override
  State<LatestPage> createState() => _LatestPageState();
}

class _LatestPageState extends State<LatestPage> {
  final _scrollController = ScrollController();
  int total = 0;
  int page = 1;
  List<NewsArticle>? _articles = [const NewsArticle(
    title: 'Loading',
    description: 'Loading',
    source: 'Loading',
    imageUrl: 'https://retchhh.files.wordpress.com/2015/03/loading1.gif',
    url: ''
  )];
  var newsHandler = News();

  void _loadMore() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        page++;
        initNews();
      });
    }
  }
  @override
  void initState(){
    super.initState();
    _scrollController.addListener(_loadMore);
    initNews();
  }
  Future<void> initNews() async {

    var data = await newsHandler.getNews(page);
    setState(() {
      if(page==1){
        _articles = data;
      }else{
        _articles = _articles!+data;
      }

      total = newsHandler.total;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                              Navigator.of(context).pushReplacementNamed('/home');
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
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
                                  style:
                                      Theme.of(context).textTheme.labelSmall,
                                ),
                                onTap: () => {
                                  Navigator.of(context).pushReplacementNamed('/feed')
                                },
                              ),
                              const Gap(16),
                              GestureDetector(
                                child: Text(
                                  "Books",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                onTap: () => {
                                  Navigator.of(context).pushReplacementNamed('/books')
                                },
                              ),
                              const Gap(16),
                              GestureDetector(
                                child: Text(
                                  "Latest",
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                                onTap: () => {
                                  Navigator.of(context).pushReplacementNamed('/latest')
                                },
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
                              controller: _scrollController,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: _articles?.length,
                              itemBuilder: (context, index) {
                                return SingleChildScrollView(
                                  child: GestureDetector(
                                    onTap: () => {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPage(url : _articles![index].url)))
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
