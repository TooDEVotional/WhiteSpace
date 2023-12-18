import 'package:flutter/material.dart';
import '../main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late bool completed;
  @override
  void initState() {
    super.initState();
    _check().then((value) => _redirect());

  }

  Future<void> _check() async {
    var b;
    if(supabase.auth.currentUser != null)
    {
      b = await supabase
        .from('learners')
        .select('profile_status')
        .eq('id', supabase.auth.currentUser!.id)
        .single();

      print(b);
      setState(() {
        completed = b['profile_status'];
      });
    }



  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final session = supabase.auth.currentSession;
    if (session == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      if (completed) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/account');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
