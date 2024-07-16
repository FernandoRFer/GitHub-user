import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:open_labs/components/app_button.dart';
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

  _testeOath() async {
    var uri = Uri.parse("https://github.com/login/oauth/authorize")
        .resolveUri(Uri(queryParameters: {
      // "reponse_type": "code",
      "client_id": "Ov23lihga4gv5k7IOqFZ",
      "scope": "user",
      "redirect_uri": "https://com.github.githubuser/",
    }));
    // log(uri.toFilePath());
    await launchUrl(
      uri,
    );

    final appLinks = AppLinks(); // AppLinks is singleton

// Subscribe to all events (initial link and further)
    var code = appLinks.uriLinkStream
      ..listen((uri) {
        log(uri.path);
        log(uri.toString());

        // Do something (navigation, ...)
      })
      ..timeout(const Duration(seconds: 10), onTimeout: (controller) {
        log('TimeOut occurred');
        controller.close();
      });
  }

  @override
  Widget build(BuildContext context) {
    _testeOath();
    return Scaffold(
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
