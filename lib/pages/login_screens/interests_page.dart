import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../main.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  List<String> interests = [
    'Science and Tech',
    'Food',
    'History',
    'AI',
    'Coding',
    'Mental Health',
    'Spiritualism',
    'Philosophy',
    'Politics',
    'Literature',
    'Startups',
  ];

  final selectedInterests = <String>[];
  var _loading = false;
  late SnackBar sb;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _completeProfile() async {
    setState(() {
      _loading = true;
    });
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'interests' : selectedInterests.join(','),
      'updated_at': DateTime.now().toIso8601String(),
      'profile_status' : true
    };
    try {
      await supabase.from('learners').upsert(updates);
      if (mounted) {
        debugPrint("done");
        sb = const SnackBar(
          content: Text('Successfully updated profile!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(sb);
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } on PostgrestException catch (error) {
      sb = SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );

      ScaffoldMessenger.of(context).showSnackBar(sb);
    } catch (error) {
      sb = SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
      ScaffoldMessenger.of(context).showSnackBar(sb);
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

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
                    child: ListView.builder(
                      itemCount: interests.length,
                      itemBuilder: (context, index) {
                        final interest = interests[index];
                        final isSelected = selectedInterests.contains(interest);
                        return CheckboxListTile(
                          checkColor: Theme.of(context).primaryColor,
                          activeColor: Theme.of(context).secondaryHeaderColor,
                          title: Text(interest),
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  selectedInterests.add(interest);
                                } else {
                                  selectedInterests.remove(interest);
                                }
                              }
                            });
                          },
                        );
                      },
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
                        onPressed: _completeProfile,
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
