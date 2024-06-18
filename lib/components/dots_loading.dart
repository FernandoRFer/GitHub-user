import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DotsLoading extends StatefulWidget {
  const DotsLoading({super.key});

  @override
  State<DotsLoading> createState() => _DotsLoadingState();
}

class _DotsLoadingState extends State<DotsLoading> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: AnimateList(
        delay: 300.ms,
        onPlay: (controller) => controller.repeat(),
        interval: 400.ms,
        effects: [FadeEffect(duration: 600.ms, begin: 0, end: 1)],
        children: [
          Text(
            ".",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            ".",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            ".",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ).then(delay: 300.ms),
    );
  }
}
