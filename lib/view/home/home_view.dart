import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:open_labs/components/app_button.dart';
import 'package:open_labs/components/bottom_sheet.dart';
import 'package:open_labs/components/error_view.dart';
import 'package:open_labs/components/loading.dart';
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
    return Scaffold(
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
      body: RefreshIndicator(
        onRefresh: () async {
          widget.bloc.load();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 40, right: 8, bottom: 8),
          child: LayoutBuilder(builder: (context, viewporConstraits) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: viewporConstraits.maxHeight,
                  maxWidth: viewporConstraits.maxWidth),
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
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                            title: const Text(
                                                "Localização do usuário"),
                                            trailing: Switch(
                                                value: snapshot.data!.filter!
                                                    .visibleUserLocation,
                                                onChanged: (value) {
                                                  widget.bloc
                                                      .setUserLocation(value);
                                                })),
                                        ListTile(
                                            title: const Text(
                                                "Número de repositórios"),
                                            trailing: Switch(
                                                value: snapshot.data!.filter!
                                                    .visibleNumberOfRepositories,
                                                onChanged: (value) {
                                                  log(value.toString());
                                                  widget.bloc
                                                      .setNumberOfRepositories(
                                                          value);
                                                })),
                                        ListTile(
                                            title: const Text(
                                                "Número de seguidores"),
                                            trailing: Switch(
                                                value: snapshot.data!.filter!
                                                    .visibleNumberOfFollowers,
                                                onChanged: (value) {
                                                  widget.bloc
                                                      .setNumberOfFollowers(
                                                          value);
                                                })),
                                        const Divider(
                                          height: 32,
                                        ),
                                      ],
                                    )),
                                LayoutBuilder(
                                    builder: (context, viewporConstraits) {
                                  return ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight: viewporConstraits.maxHeight,
                                        maxWidth: viewporConstraits.maxWidth),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: CircleAvatar(
                                            maxRadius: 40,
                                            child: ClipOval(
                                              child: Image.network(
                                                user.avatarUrl ?? "",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    user.publicRepos.toString(),
                                                  ),
                                                  const Text("repos"),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(user.followers
                                                      .toString()),
                                                  const Text("seguidores"),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(user.following
                                                      .toString()),
                                                  const Text("seguindo"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  user.name ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),

                                _customListTite(subtitle: user.login),
                                _customListTite(
                                  tite: "localização",
                                  subtitle: user.location,
                                ),
                                // _customListTite(
                                //   tite: "número de repositórios",
                                //   subtitle: user.publicRepos.toString(),
                                // ),
                                _customListTite(
                                    tite: "email", subtitle: user.email),
                                _customListTite(
                                  subtitle: user.bio,
                                ),
                                _customListTite(
                                  tite: "blog",
                                  subtitle: user.blog,
                                ),
                                _customListTite(
                                  tite: "empresa",
                                  subtitle: user.company,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                _customListTite(
                                  tite: "criado",
                                  subtitle: AppDateTimeHelper.dateTimeFormat(
                                      user.createdAt),
                                ),
                                _customListTite(
                                  tite: "ultima atualização",
                                  subtitle: AppDateTimeHelper.dateTimeFormat(
                                    user.updatedAt,
                                  ),
                                ),
                                Text(
                                  'Repos',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const Divider(),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        snapshot.data!.userReposModel.length,
                                    separatorBuilder: (context, index) {
                                      return const Divider();
                                    },
                                    itemBuilder: (context, index) {
                                      final repos =
                                          snapshot.data!.userReposModel[index];
                                      return SizedBox(
                                        height: 60,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  repos?.name ?? '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(repos?.language ?? '')
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
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
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
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

                    return Center(
                      child: Text("Encontre um usuário GitHub",
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center),
                    );
                  }),
            );
          }),
        ),
      ),
    );
  }

  Widget _customListTite({
    String tite = "",
    String? subtitle,
  }) {
    return Visibility(
        visible: subtitle != null && subtitle.isNotEmpty,
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
            subtitle ?? "",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ]));
  }
}
