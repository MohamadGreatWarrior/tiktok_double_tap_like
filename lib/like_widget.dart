part of 'double_tap_like_widget.dart';

const List<double> _angles = [pi / 9, 0, -pi / 9];

class _LikeWidget extends StatefulWidget {
  const _LikeWidget({
    required this.width,
    required this.height,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 950),
  });

  final Duration animationDuration;
  final double width;
  final double height;
  final Widget child;

  @override
  State createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<_LikeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  late final Animation<double> sizeAnimation;
  late final Animation<double> sizeAnimation2;
  late final Animation<double> sizeAnimation3;

  late final Animation<double> slideAnimation;
  late final Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    sizeAnimation = Tween(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.35),
      ),
    );

    sizeAnimation2 = Tween(begin: 1.0, end: 1.07).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.35, 0.40),
      ),
    );

    sizeAnimation3 = Tween(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.70, 1.0),
      ),
    );

    slideAnimation = Tween(begin: 0.0, end: -70.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.70, 1.0),
      ),
    );

    opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.70, 1.0),
      ),
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  var angle = _angles[Random().nextInt(3)];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(
              sizeAnimation.value,
              sizeAnimation.value,
            )
            ..scale(
              sizeAnimation2.value,
              sizeAnimation2.value,
            )
            ..scale(
              sizeAnimation3.value,
              sizeAnimation3.value,
            )
            ..translate(
              0.0,
              slideAnimation.value,
            ),
          child: Opacity(
            opacity: opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: Transform.rotate(
        angle: angle,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: widget.child,
        ),
      ),
    );
  }
}
