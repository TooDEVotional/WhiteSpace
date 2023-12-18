import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:white_space/pages/feed_screens/books_page.dart';
import 'package:white_space/pages/feed_screens/experiment_page.dart';
import 'package:white_space/pages/feed_screens/feed_page.dart';
import 'package:white_space/pages/feed_screens/home_page.dart';
import 'package:white_space/pages/feed_screens/latest_page.dart';
import 'package:white_space/pages/feed_screens/reflect_page.dart';
import 'package:white_space/pages/login_screens/account_page.dart';
import 'package:white_space/pages/login_screens/email_screen.dart';
import 'package:white_space/pages/login_screens/interests_page.dart';
import 'package:white_space/pages/login_screens/name_screen.dart';
import 'package:white_space/pages/onboarding_screens/first_onb_page.dart';
import 'package:white_space/pages/splash_page.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: '',
    anonKey: '',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

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
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (_) => const SplashPage(),
          '/login': (_) => const FirstOnboardingPage(),
          '/account': (_) => const NamePage(),
          '/home': (_) => const HomeScreen(),
          '/interests': (_) => const InterestScreen(),
          '/books': (_) => const BooksPage(),
          '/experiment': (_) => const ExperimentScreen(),
          '/latest': (_) => const LatestPage(),
          '/feed': (_) => const FeedPage(),
          '/reflect': (_) => const ReflectScreen(),

        },
      // home: BooksPage(),
    );
  }
}
