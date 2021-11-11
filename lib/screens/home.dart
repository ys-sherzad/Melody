import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:melody/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:melody/widgets/scale_animation.dart';

double _headerHeight = 88;
double _bottomBottomHeight = 80;

class Section extends HookWidget {
  const Section({
    Key? key,
    required this.bottomOffset,
    required this.height,
    required this.backgroundImage,
    required this.title,
    required this.subtitle,
    this.isClipped = false,
  }) : super(key: key);

  final double bottomOffset;
  final double height;
  final String backgroundImage;
  final bool isClipped;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    var ktitleStyle = const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );

    var ksubtitleStyle = TextStyle(
      fontSize: 14,
      shadows: [
        Shadow(
          color: Colors.white.withOpacity(.4),
          blurRadius: 2,
        ),
      ],
      color: Colors.white.withOpacity(.5),
    );

    var child = Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(.55),
              BlendMode.darken,
            ),
          ),
        ),
        height: height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: ktitleStyle),
            const SizedBox(height: 3),
            Text(subtitle, style: ksubtitleStyle),
            const SizedBox(height: 35),
          ],
        ));

    return Positioned(
      bottom: bottomOffset,
      right: 0,
      left: 0,
      child: isClipped
          ? ClipPath(
              clipBehavior: Clip.antiAlias,
              clipper: Clipper(),
              child: child,
            )
          : child,
    );
  }
}

_buildNavButton({iconPath, onPressed}) {
  return CircleAvatar(
    radius: 32,
    backgroundColor: Colors.grey.withOpacity(.5),
    child: CircleAvatar(
      radius: 28,
      backgroundColor: Colors.white.withOpacity(.8),
      child: SvgPicture.asset(
        iconPath,
        color: Colors.black,
        height: 32,
        width: 32,
      ),
    ),
  );
}

class Home extends HookWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double _screenHeight = size.height;
    double _screenWidth = size.width;

    double _height = _screenHeight / 2;

    double _offset = _height / 2;

    Widget _bottomButtons = Positioned(
      bottom: _bottomBottomHeight - 18,
      width: _screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildNavButton(iconPath: 'assets/icons/focus.svg'),
          const SizedBox(width: 1),
          _buildNavButton(iconPath: 'assets/icons/relax.svg'),
          const SizedBox(width: 1),
          _buildNavButton(iconPath: 'assets/icons/sleep.svg'),
        ],
      ),
    );

    return Scaffold(
      body: Container(
        color: ColorLib.backgroundColor,
        height: _screenHeight,
        width: _screenWidth,
        child: Stack(
          children: [
            Section(
              title: 'Meditation',
              subtitle: 'discover happiness',
              bottomOffset: (_height * 2) - (_offset * 2),
              height: _height,
              backgroundImage: 'assets/images/fernando-paredes.jpg',
            ),
            // _container1,
            Section(
              title: 'Daydream',
              subtitle: 'go beyond the form',
              bottomOffset: _height - _offset,
              height: _height,
              backgroundImage: 'assets/images/rolands-varsbergs.jpg',
              isClipped: true,
            ),
            Section(
              title: 'Sensations',
              subtitle: 'feel the moment',
              bottomOffset: 0,
              height: _height,
              backgroundImage: 'assets/images/omar-gattis.jpg',
              isClipped: true,
            ),
            BottomBar(),
            _bottomButtons,
            Header(),
            // _container4,
            // _container5
          ],
        ),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var _height = size.height;
    var _width = size.width;

    var controlPoint1 = Offset(30, _height / 2.4);
    var controlPoint2 = Offset(_width - 30, 0);
    var endPoint = Offset(_width, _height / 2.4);

    var path = Path()
      ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, endPoint.dx, endPoint.dy)
      ..lineTo(_width, _height)
      ..lineTo(0, _height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BottomBar extends HookWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _activeTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white.withOpacity(.8),
    );
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: _bottomBottomHeight,
      child: ClipPath(
        clipBehavior: Clip.antiAlias,
        clipper: BottomBarClipper(),
        child: Container(
          padding: const EdgeInsets.only(top: 14),
          width: double.infinity,
          color: ColorLib.secondary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Focus',
                style: _activeTextStyle,
              ),
              const SizedBox(width: 1),
              Text(
                'Relax',
                style: _activeTextStyle,
              ),
              const SizedBox(width: 1),
              Text(
                'Sleep',
                style: _activeTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var _height = size.height;
    var _width = size.width;

    // var controlPoint = Offset(size.width / 2, size.height / 2);
    // var endPoint = Offset(size.width, size.height);

    var path = Path()
      ..cubicTo(_width / 12, 0, _width / 12, 2 * _height / 5, 2 * _width / 12,
          2 * _height / 5)
      ..cubicTo(3 * _width / 12, 2 * _height / 5, 3 * _width / 12, 0,
          4 * _width / 12, 0)
      ..cubicTo(5 * _width / 12, 0, 5 * _width / 12, 2 * _height / 5,
          6 * _width / 12, 2 * _height / 5)
      ..cubicTo(7 * _width / 12, 2 * _height / 5, 7 * _width / 12, 0,
          8 * _width / 12, 0)
      ..cubicTo(9 * _width / 12, 0, 9 * _width / 12, 2 * _height / 5,
          10 * _width / 12, 2 * _height / 5)
      ..cubicTo(
          11 * _width / 12, 2 * _height / 5, 11 * _width / 12, 0, _width, 0)
      ..lineTo(_width, _height)
      ..lineTo(0, _height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Header extends HookWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Positioned(
      top: statusBarHeight,
      left: 0,
      right: 0,
      height: _headerHeight,
      // width: double.infinity,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScaleAnimation(
              child: SvgPicture.asset(
                'assets/icons/signal.svg',
                semanticsLabel: 'icon',
                height: 32,
                width: 32,
                fit: BoxFit.contain,
                color: Colors.white.withOpacity(.8),
              ),
            ),
            ScaleAnimation(
              child: Stack(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 65,
                        height: 65,
                        padding: const EdgeInsets.all(2),
                        color: Colors.white.withOpacity(.8),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  AssetImage('assets/images/profile-img.jpg'),
                            ),
                            // color: Colors.white.withOpacity(.8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 3,
                    child: ScaleAnimation(
                      delay: const Duration(milliseconds: 2400),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          'assets/icons/lines.svg',
                          semanticsLabel: 'icon',
                          height: 24,
                          width: 24,
                          fit: BoxFit.contain,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ScaleAnimation(
              child: SvgPicture.asset(
                'assets/icons/bell.svg',
                semanticsLabel: 'icon',
                height: 26,
                width: 26,
                fit: BoxFit.contain,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
