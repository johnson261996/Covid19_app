
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CovidMapScreen extends StatefulWidget {
  const CovidMapScreen({Key? key}) : super(key: key);

  @override
  State<CovidMapScreen> createState() => _CovidMapScreenState();
}

class _CovidMapScreenState extends State<CovidMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid Map'),
      ),
      body: const WebView(
        initialUrl: 'https://covid19.who.int/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
