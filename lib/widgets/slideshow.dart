import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      create: (_) => new _SlideshowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (BuildContext context) {
              Provider.of<_SlideshowModel>(context).primaryColor =
                  this.primaryColorDots;
              Provider.of<_SlideshowModel>(context).secundaryColor =
                  this.secundaryColorDots;

              return _CreateSlideshowStructure(
                  pointsAbove: pointsAbove, slides: slides);
            },
          ),
        ),
      ),
    );
  }
}

class _CreateSlideshowStructure extends StatelessWidget {
  const _CreateSlideshowStructure({
    Key key,
    @required this.pointsAbove,
    @required this.slides,
  }) : super(key: key);

  final bool pointsAbove;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (this.pointsAbove) _Dots(this.slides.length),
        Expanded(child: _Slides(this.slides)),
        if (!this.pointsAbove) _Dots(this.slides.length),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;

  _Dots(
    this.totalSlides,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      //color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(this.totalSlides, (i) => _Dot(i)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    //final pageViewIndex = Provider.of<_SlideshowModel>(context).currentPage;
    final slideshowModel = Provider.of<_SlideshowModel>(context);

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: (slideshowModel.currentPage >= index - 0.5 &&
                slideshowModel.currentPage < index + 0.5)
            ? slideshowModel.primaryColor
            : slideshowModel.secundaryColor,
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
      Provider.of<_SlideshowModel>(context, listen: false).currentPage =
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

class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _primaryColor = Colors.pink;
  Color _secundaryColor = Colors.grey;

  double get currentPage => this._currentPage;

  set currentPage(double page) {
    this._currentPage = page;
    notifyListeners();
  }

  Color get primaryColor => this._primaryColor;

  set primaryColor(Color color) {
    this._primaryColor = color;
  }

  Color get secundaryColor => this._secundaryColor;

  set secundaryColor(Color color) {
    this._secundaryColor = color;
  }
}
