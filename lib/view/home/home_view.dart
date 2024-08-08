import 'package:flutter/material.dart';
import 'package:github_user/components/app_button.dart';
import 'package:github_user/components/bottom_sheet.dart';
import 'package:github_user/components/error_view.dart';
import 'package:github_user/components/loading.dart';
import 'package:github_user/core/helpers/global_error.dart';
import 'package:github_user/view/home/componets/home_components.dart';
import 'home_bloc.dart';

class HomeView extends StatefulWidget {
  final IHomeBloc bloc;
  const HomeView(
    this.bloc, {
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _userController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.bloc.load();
    widget.bloc.onUserName.listen((value) {
      _userController.value = TextEditingValue(text: value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
    _userController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HomeModelBloc>(
        stream: widget.bloc.onFetchingData,
        initialData: HomeModelBloc("Initial state", isLoading: false),
        builder: (context, snapshot) {
          if (!snapshot.hasError) {
            if (snapshot.hasData) {
              if (snapshot.data!.isLoading) {
                return Center(
                  child: AnimatedLoading(title: snapshot.data!.state),
                );
              }

              if (snapshot.data!.user != null) {
                return HomeComponents(
                    homeModel: snapshot.data!, bloc: widget.bloc);
              }
            }
          } else {
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
                          widget.bloc.load();
                          widget.bloc.navigatorPop();
                        },
                      ),
                    ]),
              );
            });
          }

          return Center(
            child: Text("Usuario não encontrado GitHub",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center),
          );
        });
  }
}


// appBar: AppBar(
                //     title: TextFormField(
                //   controller: _userController,
                //   enableInteractiveSelection: true,
                //   showCursor: false,
                //   readOnly: true,
                //   onTap: () => widget.bloc.navigatorSearch(),
                //   textInputAction: TextInputAction.done,
                //   decoration: InputDecoration(
                //       prefixIcon: const Icon(Icons.search),
                //       suffixIcon: IconButton(
                //         icon: const Icon(Icons.filter_alt_outlined),
                //         onPressed: () {
                //           widget.bloc.visibleFilter();
                //         },
                //       )),
                // )),