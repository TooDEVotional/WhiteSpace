import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../main.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});


  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  late SnackBar sb;
  var _loading = false;
  final _nameController = TextEditingController();
  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });
    final name = _nameController.text.trim();
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'name': name,
      'interests' : '',
      'updated_at': DateTime.now().toIso8601String(),
    };
    try {
      await supabase.from('learners').upsert(updates);
      if (mounted) {
        debugPrint("done");
        sb = const SnackBar(
          content: Text('Successfully updated profile!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(sb);
        Navigator.of(context).pushReplacementNamed('/interests');
      }
    } on PostgrestException catch (error) {
      sb = SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );

      ScaffoldMessenger.of(context).showSnackBar(sb);
    } catch (error) {
      sb = SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
      ScaffoldMessenger.of(context).showSnackBar(sb);
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    //print(newheight * 0.2);
    //print(width * 0.4);


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
                'assets/Self confidence-bro.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Gap(16),
          Text(
            "Please enter your \nname.",
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Your Name.",
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
                  onPressed: _loading ? null : _updateProfile,
                  icon: Icon(
                    _loading ? Icons.stop : Icons.arrow_forward,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    )));
  }
}
