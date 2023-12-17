import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

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
                width: 84,
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Gap(8),
              Container(
                height: 8,
                width: 84,
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Gap(8),
              Container(
                height: 8,
                width: 84,
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          // Gap(16),
          Center(
            child: SizedBox(
              height: newheight * 0.5,
              width: width * 0.5,
              child: SvgPicture.asset(
                'assets/Innovation-amico.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Gap(16),
          Text(
            "Learn Like a Leader.",
            style: TextStyle(
              fontSize: 24.0,
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
        ],
      ),
    )));
  }
}
