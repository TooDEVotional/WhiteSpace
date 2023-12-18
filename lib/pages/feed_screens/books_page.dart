import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:white_space/components/feed_card.dart';
import 'package:white_space/models/book_models.dart';
import 'package:white_space/pages/feed_screens/home_page.dart';
import 'package:white_space/pages/feed_screens/view_page.dart';
import 'package:white_space/services/books.dart';
import 'package:url_launcher/url_launcher.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  int total = 0;
  List<BookArticle>? _articles = [const BookArticle(
    title: 'Loading',
    description: 'Loading',
    author: 'Loading',
    imageUrl: 'https://retchhh.files.wordpress.com/2015/03/loading1.gif',
    url: ''
  )];
  var bookHandler = Books();

  Future<void> _launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
    throw Exception('Could not launch $url');
    }
  }


  @override
  void initState(){
    super.initState();
    initBooks();
  }
  Future<void> initBooks() async {

    var data = await bookHandler.getBooks();
    setState(() {
        _articles = data;

      total = bookHandler.total;
    });
  }

  @override
  void dispose() {
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
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
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                                onTap: () => {
                                  Navigator.of(context).pushReplacementNamed('/books')
                                },
                              ),
                              const Gap(16),
                              GestureDetector(
                                child: Text(
                                  "Latest",
                                  style: Theme.of(context).textTheme.labelSmall,
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
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: _articles?.length,
                              itemBuilder: (context, index) {
                                return SingleChildScrollView(
                                  child: GestureDetector(
                                    onTap: () => {
                                      _launch(_articles![index].url)
                                    },
                                    child: FeedCard(
                                      newheight: newheight,
                                      width: width,
                                      title: '${_articles![index].title}',
                                      description: _articles![index].author,
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
