import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sprung/sprung.dart';

class ScaleAnimation extends HookWidget {
  const ScaleAnimation({
    Key? key,
    required this.child,
    required this.delay,
  }) : super(key: key);

  final Widget child;
  final int delay;

  @override
  Widget build(BuildContext context) {
    final _controller = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );

    final _animation = useMemoized(
        () => Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Sprung.underDamped,
              ),
            ),
        [_controller]);

    useEffect(() {
      Future.delayed(Duration(milliseconds: delay), () {
        _controller.forward();
      });
    }, []);

    return ScaleTransition(
      scale: _animation,
      child: child,
    );
  }
}
