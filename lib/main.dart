import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:white_space/pages/home_page.dart';
import 'package:white_space/pages/login_screens/email_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFFF1FAEE),
        secondaryHeaderColor: const Color(0xFF1E1E1E),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFF1E1E1E).withOpacity(0.6),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        fontFamily: GoogleFonts.outfit().fontFamily,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E1E1E),
          ),
          displayMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1E1E1E),
          ),
          displaySmall: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1E1E1E),
          ),
        ),
      ),
      home: const EmailPage(),
    );
  }
}