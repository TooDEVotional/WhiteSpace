import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:white_space/components/experiment_add_card.dart';
import 'package:white_space/components/experiment_history_card.dart';
import 'package:white_space/components/feed_card.dart';
import 'package:white_space/pages/feed_screens/feed_page.dart';

import '../../main.dart';

class ExperimentScreen extends StatefulWidget {
  const ExperimentScreen({super.key});

  @override
  State<ExperimentScreen> createState() => _ExperimentScreenState();
}

class _ExperimentScreenState extends State<ExperimentScreen> {
  String? _imageUrl;
  List<FileObject> _exp = [
    const FileObject(
        name: 'Loading',
        bucketId: null,
        owner: null,
        id: null,
        updatedAt: null,
        createdAt: null,
        lastAccessedAt: null,
        metadata: null,
        buckets: null)
  ];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker.platform.getImageFromSource(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _imageUrl = pickedFile.path;
      });
      final avatarFile = File(_imageUrl!);
      final String path = await supabase.storage.from('Exp_Images').upload(
            'experiments/${supabase.auth.currentUser?.id}/${DateTime.now().toIso8601String()}.png',
            avatarFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
    }
    fetchImg();
  }

  @override
  void initState() {
    fetchImg();
    super.initState();
  }

  Future<void> fetchImg() async {
    final List<FileObject> objects = await supabase.storage
        .from('Exp_Images')
        .list(path: 'experiments/${supabase.auth.currentUser?.id}');

    setState(() {
      _exp = objects;
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
                      GestureDetector(
                        child: Text('Read',
                            style: Theme.of(context).textTheme.displaySmall),
                        onTap: () => {
                          Navigator.of(context).pushReplacementNamed('/home')
                        },
                      ),
                      const Gap(8),
                      GestureDetector(
                        child: Text('Reflect',
                            style: Theme.of(context).textTheme.displaySmall),
                        onTap: () => {
                          Navigator.of(context).pushReplacementNamed('/reflect')
                        },
                      ),
                      const Gap(8),
                      GestureDetector(
                        child: Text(
                          'Experiment',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        onTap: () => {
                          Navigator.of(context).pushReplacementNamed('/experiment')
                        },
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
                        child: ExperimentAddCard(
                            newheight: newheight, width: width)),
                    Gap(24),
                    ExperimentHistoryCard(
                        newheight: newheight, width: width, file: _exp)
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
