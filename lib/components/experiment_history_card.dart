import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExperimentHistoryCard extends StatelessWidget {
  const ExperimentHistoryCard({
    super.key,
    required this.newheight,
    required this.width,
    required this.file,
  });

  final double newheight;
  final double width;
  final List<FileObject> file;

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
          child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: file.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Container(
                    width: width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(file[index].name, style: TextStyle(
                      fontSize: 20,
                    ),),
                  ),
                );
              })),
    );
  }
}
