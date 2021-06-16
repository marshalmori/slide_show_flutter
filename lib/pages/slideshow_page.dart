import 'package:flutter/material.dart';
import 'package:slide_show/widgets/slideshow.dart';

class SlideshowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Slideshow(),
      ),
    );
  }
}
