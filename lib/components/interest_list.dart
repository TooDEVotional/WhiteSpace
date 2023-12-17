import 'package:flutter/material.dart';

class InterestList extends StatefulWidget {
  const InterestList({Key? key}) : super(key: key);

  @override
  State<InterestList> createState() => _InterestListState();
}

class _InterestListState extends State<InterestList> {
  List<String> interests = [
    'Science and tech',
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

  final _selectedInterests = <String>[];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: interests.length,
      itemBuilder: (context, index) {
        final interest = interests[index];
        final isSelected = _selectedInterests.contains(interest);
        return CheckboxListTile(
          checkColor: Theme.of(context).primaryColor,
          activeColor: Theme.of(context).secondaryHeaderColor,
          title: Text(interest),
          value: isSelected,
          onChanged: (value) {
            setState(() {
              if (value != null) {
                if (value) {
                  _selectedInterests.add(interest);
                } else {
                  _selectedInterests.remove(interest);
                }
              }
            });
          },
        );
      },
    );
  }
}
