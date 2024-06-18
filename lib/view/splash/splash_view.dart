import 'package:flutter/material.dart';
import 'package:open_labs/components/appButton.dart';
import 'package:open_labs/components/loading.dart';
import 'package:open_labs/core/helpers/bottom_sheet_helper.dart';
import 'package:open_labs/view/splash/splash_bloc.dart';

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
      // appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<SplashModel>(
            stream: widget.bloc.onFetchingData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  BottomSheetHelper().bottomSheetCustom(
                      title: "Error",
                      subtitle: snapshot.error.toString(),
                      isDismissible: true,
                      enableDrag: false,
                      context: context,
                      buttons: [
                        AppOutlinedButton(
                          "Back",
                          onPressed: () {
                            widget.bloc.navigatorPop();
                          },
                        ),
                      ]);
                });
              }
              return const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "seja benvindo\na busca de usuários GitHub",
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
