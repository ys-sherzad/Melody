import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sprung/sprung.dart';

class ScaleAnimation extends HookWidget {
  const ScaleAnimation({
    Key? key,
    required this.child,
    this.delay = const Duration(seconds: 2),
  }) : super(key: key);

  final Widget child;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    final _controller = useAnimationController(
      duration: const Duration(milliseconds: 1200),
    );

    final _animation = useMemoized(
        () => Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Sprung.criticallyDamped,
              ),
            ),
        [_controller]);

    useEffect(() {
      Future.delayed(delay, () {
        _controller.forward();
      });
      return _controller.dispose;
    }, []);

    return ScaleTransition(
      scale: _animation,
      child: child,
    );
  }
}
