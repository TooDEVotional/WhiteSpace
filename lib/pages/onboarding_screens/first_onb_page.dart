import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:white_space/pages/login_screens/name_screen.dart';
import 'package:white_space/pages/onboarding_screens/read_onb_page.dart';

class FirstOnboardingPage extends StatelessWidget {
  const FirstOnboardingPage({super.key});

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    print(newheight * 0.2);
    print(width * 0.4);

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 8,
                width: 104,
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Gap(8),
              Container(
                height: 8,
                width: 104,
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Gap(8),
              Container(
                height: 8,
                width: 104,
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          Gap(200),
          Text(
            "WhiteSpace",
            style: TextStyle(
              fontSize: 64.0,
              fontWeight: FontWeight.w100,
              color: Color(0x991E1E1E),
            ),
            textAlign: TextAlign.start,
            overflow: TextOverflow.visible,
            maxLines: 2,
          ),
          Gap(120),
          Text(
            "Learn Like a Leader.",
            style: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E1E),
            ),
            textAlign: TextAlign.start,
          ),
          Gap(16),
          Text(
              "Embrace the 5-hour rule: Learn, read, reflect, experiment weekly for growth—inspired by visionaries who achieved greatness.",
              maxLines: 4,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF1E1E1E).withOpacity(0.6),
              )),
          Gap(32),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Theme.of(context).secondaryHeaderColor,
              ),
              width: width,
              height: 64,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context)
                        .secondaryHeaderColor, // Background color
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SecondOnboardingPage()));
                  },
                  child: Text(
                    "Start",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ))),
          Gap(16),
          Center(
            child: GestureDetector(
              onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NamePage()));
                  },
              child: Text("Skip to Authenticate",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF1E1E1E).withOpacity(0.6),
                  )),
            ),
          ),
        ],
      ),
    )));
  }
}
