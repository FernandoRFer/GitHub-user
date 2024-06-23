import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:open_labs/components/app_button.dart';
import 'package:open_labs/components/loading.dart';
import 'package:open_labs/core/helpers/bottom_sheet_helper.dart';
import 'package:open_labs/core/helpers/datetime_helper.dart';
import 'package:open_labs/core/helpers/global_error.dart';

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
    return Scaffold(
      appBar: AppBar(
          title: TextFormField(
        controller: _userController,
        enableInteractiveSelection: true,
        showCursor: false,
        readOnly: true,
        onTap: () => widget.bloc.navigatorSearch(),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.filter_alt_outlined),
              onPressed: () {
                widget.bloc.visibleFilter();
              },
            )),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<HomeModelBloc>(
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
                    final user = snapshot.data!.user!;

                    final filter = snapshot.data!.filter!;
                    return Column(
                      children: [
                        Visibility(
                            visible: snapshot.data!.visibleFilter,
                            child: Column(
                              children: [
                                // ListTile(
                                //     title:
                                //         const Text("Linguagem de programação"),
                                //     trailing: Switch(
                                //         value: snapshot.data!.filter!
                                //             .visibleProgrammingLanguage,
                                //         onChanged: (value) {
                                //           widget.bloc
                                //               .setProgrammingLanguage(value);
                                //         })),
                                ListTile(
                                    title: const Text("Localização do usuário"),
                                    trailing: Switch(
                                        value: snapshot
                                            .data!.filter!.visibleUserLocation,
                                        onChanged: (value) {
                                          widget.bloc.setUserLocation(value);
                                        })),
                                ListTile(
                                    title: const Text("Número de repositórios"),
                                    trailing: Switch(
                                        value: snapshot.data!.filter!
                                            .visibleNumberOfRepositories,
                                        onChanged: (value) {
                                          log(value.toString());
                                          widget.bloc
                                              .setNumberOfRepositories(value);
                                        })),
                                ListTile(
                                    title: const Text("Número de seguidores"),
                                    trailing: Switch(
                                        value: snapshot.data!.filter!
                                            .visibleNumberOfFollowers,
                                        onChanged: (value) {
                                          widget.bloc
                                              .setNumberOfFollowers(value);
                                        })),
                                const Divider(
                                  height: 32,
                                ),
                              ],
                            )),
                        Expanded(
                          child: ListView(
                            children: [
                              CircleAvatar(
                                radius: 100,
                                child: ClipOval(
                                  child: Image.network(
                                    user.avatarUrl,
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 200,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Visibility(
                                visible: filter.visibleNumberOfFollowers,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(user.followers.toString()),
                                          const Text("seguidores"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(user.following.toString()),
                                          const Text("seguindo"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                user.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              _customListTite(subtitle: user.login),
                              _customListTite(
                                  tite: "localização",
                                  subtitle: user.location,
                                  visible: filter.visibleUserLocation),
                              _customListTite(
                                  tite: "número de repositórios",
                                  subtitle: user.publicRepos.toString(),
                                  visible: filter.visibleNumberOfRepositories),
                              // _customListTite(
                              //     tite: "linguagem de programação",
                              //     // subtitle: user.language,
                              //     visible: user.location.isNotEmpty),
                              _customListTite(
                                  tite: "email", subtitle: user.email),
                              _customListTite(
                                  subtitle: user.bio,
                                  visible: user.bio.isNotEmpty),
                              _customListTite(
                                  tite: "blog",
                                  subtitle: user.blog,
                                  visible: user.blog.isNotEmpty),
                              _customListTite(
                                tite: "empresa",
                                subtitle: user.company,
                                visible: user.company.isNotEmpty,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              _customListTite(
                                tite: "criado",
                                subtitle: AppDateTimeHelper.dateTimeFormat(
                                    user.createdAt),
                                visible: user.createdAt.isNotEmpty,
                              ),
                              _customListTite(
                                tite: "ultima atualização",
                                subtitle: AppDateTimeHelper.dateTimeFormat(
                                  user.updatedAt,
                                ),
                                visible: user.updatedAt.isNotEmpty,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                }
              } else {
                final error = snapshot.error as GlobalErrorModel;
                if (error.message == "Not found") {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.search_off_outlined, size: 75),
                        Text(
                          "Usuário não encontrado",
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Verifique o nome do usuário e tente novamente",
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  BottomSheetHelper().bottomSheetCustom(
                      subtitle: snapshot.error.toString(),
                      isDismissible: true,
                      enableDrag: false,
                      context: context,
                      buttons: [
                        AppOutlinedButton(
                          "Voltar",
                          onPressed: () {
                            widget.bloc.navigatorPop();
                          },
                        ),
                      ]);
                });
              }

              return Center(
                child: Text("Encontre um usuário GitHub",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center),
              );
            }),
      ),
    );
  }

  Widget _customListTite(
      {String tite = "", String subtitle = "", bool visible = false}) {
    return Visibility(
        visible: visible,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          tite.isNotEmpty
              ? Text(
                  tite,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              : const SizedBox(),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ]));
  }
}
