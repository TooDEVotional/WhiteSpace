import 'package:flutter/material.dart';
import 'package:white_space/pages/login_screens/name_screen.dart';

class SkipToAuth extends StatelessWidget {
  const SkipToAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NamePage()));
            },
        child: Text("Skip to Authenticate",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF1E1E1E).withOpacity(0.6),
            )),
      ),
    );
  }
}
