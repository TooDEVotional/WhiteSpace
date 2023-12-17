import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class NamePage extends StatelessWidget {
  const NamePage({super.key});

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Gap(16),
              IconButton.filled(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color(0xFF1E1E1E).withOpacity(0.6)),
                      shape: MaterialStateProperty.all(CircleBorder()))),
              Gap(16),
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
          Gap(16),
          Center(
            child: SizedBox(
              height: newheight * 0.2,
              width: width * 0.4,
              child: SvgPicture.asset(
                'assets/Self confidence-bro.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Gap(16),
          Text(
            "Please enter your \nname.",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E1E),
            ),
            textAlign: TextAlign.start,
          ),
          Gap(16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Your Name.",
                    hintStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E1E1E).withOpacity(0.6),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xFF1E1E1E).withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(4),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    )));
  }
}
