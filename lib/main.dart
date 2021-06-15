import 'package:flutter/material.dart';
import 'package:slide_show/pages/slide_show_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: SlideShowPage(),
    );
  }
}
