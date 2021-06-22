import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slide_show/widgets/slideshow.dart';

class SlideshowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Slideshow(
        primaryDotSize: 12,
        secundaryDotSize: 12,
        pointsAbove: false,
        primaryColorDots: Colors.purple.shade900,
        secundaryColorDots: Colors.grey,
        slides: [
          SvgPicture.asset('assets/svgs/1.svg'),
          SvgPicture.asset('assets/svgs/2.svg'),
          SvgPicture.asset('assets/svgs/3.svg'),
          SvgPicture.asset('assets/svgs/4.svg'),
          SvgPicture.asset('assets/svgs/5.svg'),
        ],
      ),
    );
  }
}
