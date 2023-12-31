import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/../main.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;
  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signInWithOtp(
        email: _emailController.text.trim(),
        emailRedirectTo:
        kIsWeb ? null : 'com.whsp.lily://login-callback/',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Check your email for a login link!')),
        );
        _emailController.clear();
      }
    } on AuthException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/account');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    print(newheight * 0.2);
    print(width * 0.4);

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Gap(16),
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
              Container(
                height: 8,
                width: 84,
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Gap(8),
              Container(
                height: 8,
                width: 84,
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Gap(8),
              Container(
                height: 8,
                width: 84,
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          Gap(16),
          Center(
            child: SizedBox(
              height: newheight * 0.2,
              width: width * 0.4,
              child: SvgPicture.asset(
                'assets/Email campaign-pana.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Gap(16),
          Text(
            "Please enter your \nemail.",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E1E),
            ),
            textAlign: TextAlign.start,
          ),
          Gap(16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email Address.",
                    hintStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1E1E1E).withOpacity(0.6),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xFF1E1E1E).withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(4),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: _isLoading ? null : _signIn,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    )));
  }
}
