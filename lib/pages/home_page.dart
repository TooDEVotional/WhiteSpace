import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showBottomSheet = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    double height = MediaQuery.of(context).size.height;
    print(height);
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
              Container(
                height: newheight * 0.4,
                width: width,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Read',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Gap(8),
                      Text('Reflect',
                          style: Theme.of(context).textTheme.displaySmall),
                      Gap(8),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Text(
                          'Experiment',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                          child: Gap(32)),
                      Text(
                        "Don't let yourself make excuses for not doing\n the things you want to do.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF1E1E1E).withOpacity(0.6),
                        ),
                      ),
                      Gap(8),
                      Text("-Sam Altman",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF1E1E1E).withOpacity(0.6),
                          ))
                    ],
                  ),
                ),
              ),
              Container(
                height: newheight * 0.6,
                width: width,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)),
                  border: Border.all(
                    color: Color(0xFF1E1E1E).withOpacity(0.4),
                  ),
                ),
                child: Column(
                  children: [
                    Gap(16),
                    // Container(
                    //   height: 8,
                    //   width: 48,
                    //   decoration: BoxDecoration(
                    //     color: Color(0xFF1E1E1E),
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    // ),
                    Container(
                        color: Theme.of(context).primaryColor,
                        height: 8,
                        child: Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: 32,
                        )),
                    //Add Scroller
                    Gap(8),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Top Picks",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Gap(16),
                          Text(
                            "Books",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF1E1E1E).withOpacity(0.6),
                            ),
                          ),
                          Gap(16),
                          Text(
                            "Latest",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF1E1E1E).withOpacity(0.6),
                            ),
                          )
                        ],
                      ),
                    ),
                    Gap(24),
                    //Add ListView here with Cards.
                    Card(
                      child: Container(
                        height: newheight * 0.2,
                        width: width - 64,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFF1E1E1E).withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),
                    //Gap(32),
                    Card(
                      child: Container(
                        height: newheight * 0.2,
                        width: width - 64,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFF1E1E1E).withOpacity(0.4),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
