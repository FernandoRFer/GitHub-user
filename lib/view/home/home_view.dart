import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_user/components/app_button.dart';
import 'package:github_user/components/bottom_sheet.dart';
import 'package:github_user/components/error_view.dart';
import 'package:github_user/components/loading.dart';
import 'package:github_user/core/helpers/global_error.dart';
import 'package:github_user/core/theme/app_theme.dart';
import 'package:github_user/repository/local%20_file/linguage_color.dart';
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
                final user = snapshot.data!.user!;

                final filter = snapshot.data!.filter!;
                return Scaffold(
                  appBar: AppBar(actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: const Icon(Icons.logout_outlined),
                        onPressed: () {
                          //Criar logout -----------

                          widget.bloc.navigatorPop();
                        },
                      ),
                    )
                  ], automaticallyImplyLeading: false),

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
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                      maxWidth: viewporConstraits.maxWidth),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                                Text(user.followers.toString()),
                                                const Text("seguidores"),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(user.following.toString()),
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
                                height: 16,
                              ),
                              Text(
                                user.name ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              _customListTite(subtitle: user.login),
                              _customListTite(
                                tite: "localização",
                                subtitle: user.location,
                              ),
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
                            ],
                          ),
                        ),
                        Container(
                          height: 24,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Repositories",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(0),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      snapshot.data!.userReposModel.length,
                                  itemBuilder: (context, index) {
                                    final repos =
                                        snapshot.data!.userReposModel[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius
                                                .all(
                                                kGlobalBorderRadiusInternal),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outlineVariant,
                                            )),
                                        height: 75,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
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
                                                                FontWeight
                                                                    .bold),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Visibility(
                                                    visible:
                                                        (repos?.language ?? '')
                                                            .isNotEmpty,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.circle,
                                                          size: 12,
                                                          color: LinguageColor()
                                                              .getColor(repos
                                                                      ?.language ??
                                                                  ''),
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(repos?.language ??
                                                            ''),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Icon(
                                                    repos?.stargazersCount == 0
                                                        ? Icons
                                                            .star_border_rounded
                                                        : Icons
                                                            .star_rate_rounded,
                                                    size: 16,
                                                    color:
                                                        repos?.stargazersCount ==
                                                                0
                                                            ? null
                                                            : Colors.amber[200],
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(repos?.stargazersCount
                                                          .toString() ??
                                                      ''),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        // _customListTite(
                        //   tite: "criado",
                        //   subtitle: AppDateTimeHelper.dateTimeFormat(
                        //       user.createdAt),
                        // ),
                        // _customListTite(
                        //   tite: "ultima atualização",
                        //   subtitle: AppDateTimeHelper.dateTimeFormat(
                        //     user.updatedAt,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                      ],
                    ),
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



// class DemoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: RefreshIndicator(
//           onRefresh: () async {
//             await Future.delayed(const Duration(seconds: 1));
//           },
//           child: CustomScrollView(
//             slivers: <Widget>[
//               SliverFillRemaining(
//                 child: Container(
//                   color: Colors.blue,
//                   child: Center(
//                     child: Text("No results found."),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }