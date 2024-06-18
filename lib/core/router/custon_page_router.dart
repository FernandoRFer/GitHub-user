import 'package:flutter/widgets.dart';

class CustonPageRouter extends PageRouteBuilder {
  final Widget child;
  CustonPageRouter({required this.child, super.settings})
      : super(
          transitionDuration: const Duration(milliseconds: 800),
          reverseTransitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: ScaleTransition(
        scale: Tween<double>(begin: 100, end: 1).animate(animation),
        child: child,
      ),
    );
  }
}
