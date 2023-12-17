import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExperimentHistoryCard extends StatelessWidget {
  const ExperimentHistoryCard({
    super.key,
    required this.newheight,
    required this.width,
  });

  final double newheight;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          height: newheight * 0.25,
          width: width - 64,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFF1E1E1E).withOpacity(0.4),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No Experiments Performed yet."),
            ],
          )),
    );
  }
}
