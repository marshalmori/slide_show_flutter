import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SlideShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: _Slides(),
            ),
            _Dots(),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      //color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Dot(0),
          _Dot(1),
          _Dot(2),
          _Dot(3),
          _Dot(4),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = new PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      print('Página atual: ${pageViewController.page}');
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        children: [
          _Slide('assets/svgs/1.svg'),
          _Slide('assets/svgs/2.svg'),
          _Slide('assets/svgs/3.svg'),
          _Slide('assets/svgs/4.svg'),
          _Slide('assets/svgs/5.svg'),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String svg;

  _Slide(this.svg);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(20),
      child: SvgPicture.asset(svg),
    );
  }
}
