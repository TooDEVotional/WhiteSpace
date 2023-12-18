import 'package:flutter/material.dart';

class OverflowText extends StatelessWidget {
  const OverflowText({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
          fit: StackFit.expand,
          children: [
            ClipRect(
              child: Column(
                children: [
                  Container(
                    width: 300,
                    height: 400,
                    color: Colors.green[200],
                    child: Text('first widget'),
                  ),
                  Container(
                    width: 350,
                    height: 350,
                    color: Colors.yellow[200],
                    child: Text('overflowed widget'),
                  ),
                ],
              ),
            ),
            Positioned(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text("SHOW THIS TEXT ONLY IF CONTENT HAS OVERFLOWED."),
              ),
            ),
          ],
        
    

    );
  }
}
