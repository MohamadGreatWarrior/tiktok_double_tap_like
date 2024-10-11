import 'package:flutter/material.dart';

import 'like_widget.dart';
import 'animated_translated_widget.dart';

class DoubleTapLikeWidget extends StatefulWidget {
  const DoubleTapLikeWidget({
    super.key,
    required this.onLike,
    required this.child,
    required this.likeWidget,
    this.translateDuration = const Duration(milliseconds: 2400),
    this.animationDuration = const Duration(milliseconds: 900),
    this.curve = Curves.easeInOutCubic,
    this.likeWidth = 200,
    this.likeHeight = 200,
  });

  final VoidCallback onLike;
  final Widget child;
  final Widget likeWidget;
  final Duration translateDuration;
  final Duration animationDuration;
  final Curve curve;
  final double likeWidth;
  final double likeHeight;

  @override
  State createState() => _DoubleTapLikeWidgetState();
}

class _DoubleTapLikeWidgetState extends State<DoubleTapLikeWidget> {
  List<HeartInfo> hearts = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: widget.child,
        ),
        ...hearts.map(
          (e) {
            return PositionedDirectional(
              key: ValueKey(e),
              start: e.x - widget.likeWidth / 2,
              top: e.y - widget.likeHeight / 1.3,
              child: AnimatedTranslateWidget(
                translateDuration: widget.translateDuration,
                curve: widget.curve,
                child: LikeWidget(
                  animationDuration: widget.animationDuration,
                  width: widget.likeWidth,
                  height: widget.likeHeight,
                  child: widget.likeWidget,
                ),
                onDispose: () {
                  setState(() {
                    hearts.remove(e);
                  });
                },
              ),
            );
          },
        ),
        GestureDetector(
          onDoubleTap: widget.onLike,
          onDoubleTapDown: (tapDownDetails) {
            setState(() {
              hearts.add(
                HeartInfo(
                  tapDownDetails.localPosition.dx,
                  tapDownDetails.localPosition.dy,
                ),
              );
            });
          },
          // child: widget.child,
        )
      ],
    );
  }
}

class HeartInfo {
  double x;
  double y;

  HeartInfo(this.x, this.y);
}
