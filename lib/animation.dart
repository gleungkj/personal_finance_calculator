import 'package:flutter/material.dart';

class AnimationPage extends StatelessWidget {
  AnimationPage({
    @required this.child,
    @required this.animation,
    @required this.start,
    @required this.finish,
  });

  final Widget child;

  final animation;

  double start;
  double finish;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(
          CurvedAnimation(
            curve: Interval(start, finish, curve: Curves.easeInCubic),
            parent: animation,
          )),
      child: child,
    );
  }

}