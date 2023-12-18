import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:white_space/components/interest_list.dart';

class MagiclinkScreen extends StatefulWidget {
  const MagiclinkScreen({super.key});

  @override
  State<MagiclinkScreen> createState() => _MagiclinkScreenState();
}

class _MagiclinkScreenState extends State<MagiclinkScreen> {
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
          Gap(16),
          Gap(16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(24),
                Text(
                  "Check your email for magic link.",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Gap(60),
                Text(
                  "Sit tight! We're generating a magic link and sending it to your email. Once received, click the link to swiftly complete the authentication process and get started.",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          )
        ],
      ),
    )));
  }
}
