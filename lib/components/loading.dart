import 'package:flutter/material.dart';
import 'package:open_labs/core/theme/app_theme.dart';
import 'dots_loading.dart';

class AnimatedLoading extends StatelessWidget {
  final String? title;
  const AnimatedLoading({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 40,
          ),
          const SizedBox(
            width: 350,
            child: LinearProgressIndicator(
              minHeight: 10,
              borderRadius: BorderRadius.all(kGlobalBorderRadiusExternal),
            ),
            //   child: const Icon(
            //     Icons.settings,
            //     size: 100,
            //   )
            //       .animate(onPlay: (animationController) {
            //         animationController.repeat();
            //       })
            //       .scaleXY(
            //           begin: 0.9,
            //           end: 1,
            //           curve: Curves.bounceInOut,
            //           duration: const Duration(milliseconds: 500))
            //       .then()
            //       .scaleXY(
            //           begin: 1,
            //           end: 0.9,
            //           curve: Curves.bounceInOut,
            //           duration: const Duration(milliseconds: 500)),
            // ).animate(onPlay: (animationController) {
            //   animationController.repeat();
            // }).rotate(
            //   duration: const Duration(milliseconds: 2000),
          ),
          const SizedBox(
            height: 8,
          ),
          title != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.justify,
                    ),
                    const DotsLoading(),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
