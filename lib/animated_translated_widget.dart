part of 'double_tap_like_widget.dart';

class _AnimatedTranslateWidget extends StatefulWidget {
  const _AnimatedTranslateWidget({
    required this.translateDuration,
    required this.child,
    required this.onDispose,
    required this.curve,
  });

  final Duration translateDuration;
  final Curve curve;
  final Widget child;
  final VoidCallback onDispose;

  @override
  State createState() => _AnimatedTranslateWidgetState();
}

class _AnimatedTranslateWidgetState extends State<_AnimatedTranslateWidget>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final Tween<Offset> offsetTween;
  late final Animation<Offset> offsetAnimation;
  double randomSize = 0;

  @override
  void initState() {
    super.initState();
    randomSize = Random().nextDouble();
    animationController = AnimationController(
      vsync: this,
      duration: widget.translateDuration,
    );
    offsetTween = Tween<Offset>(
      begin: Offset.zero,
      end: offset,
    );
    offsetAnimation = offsetTween.animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutCubic,
    ));
    animationController.forward().then((_) {
      widget.onDispose();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  double get opacity {
    if (animationController.value < 0.2) {
      return animationController.value / 0.2;
    }
    if (animationController.value > 0.8) {
      return (1 - animationController.value) / 0.2;
    } else {
      return 1;
    }
  }

  Offset get offset {
    final direction = Random().nextBool() ? -1 : 1;
    double x = direction * Random().nextDouble() * 100;
    double y = -Random().nextDouble() * 500 - 100;
    return Offset(x, y);
  }

  double get size {
    return 1 + animationController.value * randomSize;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: offsetAnimation.value,
            child: Transform.scale(
              scale: size,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
