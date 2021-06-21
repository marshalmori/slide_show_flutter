import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_show/models/slider_model.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool pointsAbove;
  final Color primaryColorDots;
  final Color secundaryColorDots;

  Slideshow({
    @required this.slides,
    this.pointsAbove = false,
    this.primaryColorDots = Colors.pink,
    this.secundaryColorDots = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new SliderModel(),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              if (this.pointsAbove)
                _Dots(this.slides.length, this.primaryColorDots,
                    this.secundaryColorDots),
              Expanded(child: _Slides(this.slides)),
              if (!this.pointsAbove)
                _Dots(this.slides.length, this.primaryColorDots,
                    this.secundaryColorDots),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;
  final Color primaryColorDots;
  final Color secundaryColorDots;

  _Dots(
    this.totalSlides,
    this.primaryColorDots,
    this.secundaryColorDots,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      //color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            this.totalSlides,
            (i) => _Dot(
                  i,
                  this.primaryColorDots,
                  this.secundaryColorDots,
                )),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  final Color primaryColorDots;
  final Color secundaryColorDots;

  _Dot(
    this.index,
    this.primaryColorDots,
    this.secundaryColorDots,
  );

  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5)
            ? secundaryColorDots
            : primaryColorDots,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  _Slides(this.slides);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = new PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      Provider.of<SliderModel>(context, listen: false).currentPage =
          pageViewController.page;
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
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(20),
      child: slide,
    );
  }
}
