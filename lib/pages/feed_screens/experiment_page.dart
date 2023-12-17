import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:white_space/components/experiment_add_card.dart';
import 'package:white_space/components/experiment_history_card.dart';
import 'package:white_space/components/feed_card.dart';
import 'package:white_space/pages/feed_screens/feed_page.dart';

class ExperimentScreen extends StatefulWidget {
  const ExperimentScreen({super.key});

  @override
  State<ExperimentScreen> createState() => _ExperimentScreenState();
}

class _ExperimentScreenState extends State<ExperimentScreen> {
  String? _imageUrl;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
    );  
    if (pickedFile != null) {
      setState(() {
        _imageUrl = pickedFile.path;
      });
    }
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
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Text('Read',
                            style: Theme.of(context).textTheme.displaySmall),
                      ),
                      const Gap(8),
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Text('Reflect',
                            style: Theme.of(context).textTheme.displaySmall),
                      ),
                      const Gap(8),
                      Text(
                        'Experiment',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const Gap(32),
                      Text(
                        "Don't let yourself make excuses for not doing\n the things you want to do.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF1E1E1E).withOpacity(0.6),
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
              Container(
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
                        onPressed: null,
                        icon: Icon(
                          Icons.horizontal_rule_rounded,
                          size: 48,
                          color: Theme.of(context).secondaryHeaderColor,
                        )),
              
                    //Add ListView here with Cards.
                    GestureDetector(
                      onTap: _pickImage,
                      child: ExperimentAddCard(newheight: newheight, width: width)),
                    Gap(24),
                    ExperimentHistoryCard(newheight: newheight, width: width)
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

// padding: const EdgeInsets.fromLTRB(0, 24, 8, 0),