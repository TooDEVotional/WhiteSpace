import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:white_space/components/interest_list.dart';
import 'package:white_space/pages/feed_screens/home_page.dart';
import 'package:white_space/pages/splash_screen.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(16),
              
              Gap(16),
            ],
          ),
          Gap(16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select your Interests",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Gap(8),
                Text(
                  "Choose 3 or more.",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Container(
                  height: newheight - (newheight * 0.48),
                  width: width - 56,
                  child: InterestList(),
                ),
                Gap(32),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    width: width,
                    height: 64,
                    child: ElevatedButton(
                        onPressed: null,
                        child: Text(
                          "Done",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )))
              ],
            ),
          )
        ],
      ),
    )));
  }
}
