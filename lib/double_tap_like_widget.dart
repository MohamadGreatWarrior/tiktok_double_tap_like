import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

part 'animated_translated_widget.dart';

part 'like_widget.dart';

class DoubleTapLikeWidget extends StatefulWidget {
  const DoubleTapLikeWidget({
    super.key,
    required this.onLike,
    required this.child,
    required this.likeWidget,
    this.translateDuration = const Duration(milliseconds: 2400),
    this.animationDuration = const Duration(milliseconds: 900),
    this.resetDuration = const Duration(milliseconds: 1500),
    this.curve = Curves.easeInOutCubic,
    this.likeWidth = 200,
    this.likeHeight = 200,
  });

  final ValueChanged<int> onLike;
  final Widget child;
  final Widget likeWidget;
  final Duration translateDuration;
  final Duration animationDuration;
  final Duration resetDuration;
  final Curve curve;
  final double likeWidth;
  final double likeHeight;

  @override
  State createState() => _DoubleTapLikeWidgetState();
}

class _DoubleTapLikeWidgetState extends State<DoubleTapLikeWidget> {
  List<HeartInfo> hearts = [];

  int likeCount = 0;

  Timer? timer;

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
              child: _AnimatedTranslateWidget(
                translateDuration: widget.translateDuration,
                curve: widget.curve,
                child: _LikeWidget(
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
          onDoubleTap: () {
            likeCount++;
            widget.onLike(likeCount);

            timer?.cancel();
            timer = Timer(
              widget.resetDuration,
              () => likeCount = 0,
            );
          },
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
