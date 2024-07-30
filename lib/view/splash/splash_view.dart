import 'package:flutter/material.dart';
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
        vsync: this, duration: const Duration(milliseconds: 1000));
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
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Seja bem vindo,\nbusca de usuário GitHub",
                    style: TextStyle(fontFamily: "Chunk", fontSize: 32),
                  ),
                  AnimatedLoading(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
