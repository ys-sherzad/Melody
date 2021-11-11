


///
///     (╯ ͡❛ ͜ʖ ͡❛)╯┻━┻
/// **************************************************************
/// Instagram @ys.sherzad  *************************
/// Twitter @ys_sherzad  ********************
/// **************************************************************
/// "Make Everyday Count" 🇦🇫
///
///

import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:melody/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:melody/widgets/scale_animation.dart';
import 'package:melody/repo/data.dart';

// ALL WIDGET ARE IN THIS FILE
//Place all widgets in a separate file

double _headerHeight = 82;
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
            Colors.black.withOpacity(.5),
            BlendMode.darken,
          ),
        ),
      ),
      height: height,
      width: double.infinity,
      child: ScaleAnimation(
        delay: animationDelay[title]!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: ktitleStyle),
            const SizedBox(height: 3),
            Text(subtitle, style: ksubtitleStyle),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );

    return Positioned(
      bottom: bottomOffset,
      right: 0,
      left: 0,
      child: isClipped
          ? FadeIn(
              child: ClipPath(
                clipBehavior: Clip.antiAlias,
                clipper: Clipper(),
                child: child,
              ),
            )
          : FadeIn(
              child: child,
            ),
    );
  }
}

_buildNavButton({
  iconPath,
  selected,
  onPressed,
}) {
  var _iconColor = selected ? ColorLib.secondary : Colors.white.withOpacity(.9);
  var _backgroundColor =
      selected ? Colors.white.withOpacity(.9) : Colors.transparent;

  return InkWell(
    onTap: onPressed,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    child: CircleAvatar(
      radius: 32,
      backgroundColor: ColorLib.secondary.withOpacity(.7),
      child: CircleAvatar(
        radius: 28,
        backgroundColor: _backgroundColor,
        child: SvgPicture.asset(
          iconPath,
          color: _iconColor,
          height: 32,
          width: 32,
        ),
      ),
    ),
  );
}

_buildNavText({
  text,
  selected,
}) {
  var _activeTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.white.withOpacity(.8),
  );

  var _inactiveTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.white.withOpacity(.4),
  );

  return Text(
    text,
    style: selected ? _activeTextStyle : _inactiveTextStyle,
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
              backgroundImage: 'assets/images/hans-vivek.jpg',
            ),
            Section(
              title: 'Daydream',
              subtitle: 'go beyond the form',
              bottomOffset: _height - _offset,
              height: _height,
              backgroundImage: 'assets/images/jono-hirst.jpg',
              isClipped: true,
            ),
            Section(
              title: 'Sensations',
              subtitle: 'feel the moment',
              bottomOffset: 0,
              height: _height,
              backgroundImage: 'assets/images/greg-rakozy.jpg',
              isClipped: true,
            ),
            const BottomBar(),
            const Header(),
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

    var controlPoint1 = Offset(40, _height / 3.1);
    var controlPoint2 = Offset(_width - 40, 0);
    var endPoint = Offset(_width, _height / 2);

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
    var tabs = useState(tabsData);

    int _getTabDelay(TabData tab) {
      var key = tab.delayKey;
      return animationDelay[key]!;
    }

    void _updateTabs(String id) {
      tabs.value = [
        for (final tab in tabs.value)
          if (tab.id == id)
            tab.copyWith(selected: true)
          else
            tab.copyWith(selected: false)
      ];
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: _bottomBottomHeight + 40,
      child: SlideInUp(
        delay: Duration(seconds: 1),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: _bottomBottomHeight,
                width: double.infinity,
                child: ClipPath(
                  clipBehavior: Clip.antiAlias,
                  clipper: BottomBarClipper(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.only(top: 14),
                      width: double.infinity,
                      color: ColorLib.secondary.withOpacity(.5),
                      // child:
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                for (final _tab in tabs.value) ...[
                  ScaleAnimation(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNavButton(
                          iconPath: _tab.icon,
                          selected: _tab.selected,
                          onPressed: () => _updateTabs(_tab.id),
                        ),
                        const SizedBox(height: 16),
                        _buildNavText(
                          text: _tab.title,
                          selected: _tab.selected,
                        ),
                      ],
                    ),
                    delay: _getTabDelay(_tab),
                  ),
                  // TODO: Build a List Tabs class, add a method to check whether
                  // the tab is the last one
                  if (_tab.title != 'Sleep') const SizedBox(width: 1)
                ]
              ],
            ),
          ],
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
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScaleAnimation(
              delay: animationDelay['header1']!,
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
              delay: animationDelay['header2']!,
              child: Stack(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 60,
                        height: 60,
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
                      delay: animationDelay['profileImgIcon']!,
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
              delay: animationDelay['header3'] as int,
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
