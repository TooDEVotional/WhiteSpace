
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FeedCard extends StatelessWidget {
  const FeedCard({
    super.key,
    required this.newheight,
    required this.width,
    required this.title,
    required this.description,
    required this.image,
  });

  final double newheight;
  final double width;
  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: newheight * 0.2,
        width: width - 64,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF1E1E1E).withOpacity(0.4),
          ),
        ),
        child: Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 8, 0),
                child: Container(
                  height: 72,
                  width: 72,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        image,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 8, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width - 176,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.displaySmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Gap(8),
                    Container(
                      width: width - 176,
                      height: (newheight * 0.2) - 72,
                      child: Text(
                        description,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF1E1E1E).withOpacity(0.6),
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
