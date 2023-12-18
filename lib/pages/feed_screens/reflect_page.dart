import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:white_space/components/feed_card.dart';
import 'package:white_space/constants/articles_data.dart';
import 'package:white_space/main.dart';
import 'package:white_space/models/article_models.dart';
import 'package:white_space/pages/feed_screens/feed_page.dart';
import 'package:white_space/services/news.dart';

class ReflectScreen extends StatefulWidget {
  const ReflectScreen({super.key});

  @override
  State<ReflectScreen> createState() => _ReflectScreenState();
}

class _ReflectScreenState extends State<ReflectScreen> {
  String quest = 'Loading';

  @override
  void initState() {
    super.initState();
    fetchQuestion();
    // Fetch articles on widget initialization
  }

  Future<void> fetchQuestion() async {
    var interests = await supabase.from('learners').select('interests').eq('id', supabase.auth.currentUser!.id).single();
    var _random = new Random();
    var data = await supabase.from('questions').select('question').eq('topic', interests['interests'].split(',')[_random.nextInt(interests['interests'].split(',').length)]);
    setState(() {
      quest = data[_random.nextInt(data.length)]['question'];
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
        child: SingleChildScrollView(
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
                      GestureDetector(
                        child: Text(
                          'Read',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        onTap: () => {
                          Navigator.of(context).pushReplacementNamed('/home')
                        },
                      ),
                      const Gap(8),
                      GestureDetector(
                        child: Text('Reflect',
                            style: Theme.of(context).textTheme.displayLarge),
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
                    border: Border(
                        top: BorderSide(
                            color: Color(0xFF1E1E1E).withOpacity(0.4)),
                        left: BorderSide(
                            color: Color(0xFF1E1E1E).withOpacity(0.4)),
                        right: BorderSide(
                            color: Color(0xFF1E1E1E).withOpacity(0.4))),
                  ),
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.horizontal_rule_rounded,
                            size: 48,
                            color: Theme.of(context).secondaryHeaderColor,
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Write",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const Gap(16),
                            // Text(
                            //   "Meditate",
                            //   style: Theme.of(context).textTheme.labelSmall,
                            // ),
                            // const Gap(16),
                            // Text(
                            //   "Discover",
                            //   style: Theme.of(context).textTheme.labelSmall,
                            // )
                          ],
                        ),
                      ),

                      //Add ListView here with Cards.
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          quest ,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Write your thoughts here...",
                            hintStyle: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                              color: const Color(0xFF1E1E1E).withOpacity(0.6),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                            ),
                          ),
                          maxLines: 4,
                          maxLength: 255,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xFF1E1E1E).withOpacity(0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
