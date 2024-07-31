import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:github_user/components/bottom_sheet.dart';
import 'package:github_user/components/error_view.dart';
import 'package:github_user/core/helpers/global_error.dart';

import 'package:github_user/components/app_button.dart';
import 'package:github_user/components/loading.dart';
import 'package:github_user/view/splash/splash_bloc.dart';

class SplashView extends StatefulWidget {
  final ISplashBloc bloc;
  const SplashView(
    this.bloc, {
    super.key,
  });

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  ValueNotifier<bool> isAuth = ValueNotifier(false);
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();

    _animation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    widget.bloc.load();
  }

  @override
  void dispose() {
    _animation.dispose();
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<SplashModel>(
            stream: widget.bloc.onFetchingData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                final error = snapshot.error as GlobalErrorModel;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Scaffold.of(context).bottomSheetCustom(
                    isDismissible: true,
                    enableDrag: true,
                    child: ErrorView(
                        title: "Error",
                        subtitle: error.message,
                        buttons: [
                          AppOutlinedButton(
                            "Back",
                            onPressed: () {
                              widget.bloc.navigatorPop();
                            },
                          ),
                        ]),
                  );
                });
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Welcome,\nGitHub repository",
                          style: TextStyle(fontFamily: "Chunk", fontSize: 30))
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(
                          duration: 1200.ms,
                          color: Theme.of(context).primaryColorLight,
                          angle: -0.2)
                  // .shimmer(
                  //     delay: 600.ms,
                  //     duration: 1200.ms,
                  //     color: Theme.of(context).primaryColorLight)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
