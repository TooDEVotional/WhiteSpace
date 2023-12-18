import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key, this.url});
  final url;
  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
          onPageStarted: (url) {},
          onProgress: (progress) {},
          onPageFinished: (url) {}))
      ..loadRequest(
        Uri.parse(widget.url),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.black54,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.close, color: Colors.white,),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
