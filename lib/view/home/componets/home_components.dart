import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_user/components/custom_list_title.dart';
import 'package:github_user/core/theme/app_theme.dart';
import 'package:github_user/repository/local%20_file/linguage_color.dart';
import 'package:github_user/view/home/home_bloc.dart';

class HomeComponents extends StatelessWidget {
  final HomeModelBloc homeModel;
  final IHomeBloc bloc;
  const HomeComponents(
      {super.key, required this.homeModel, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final user = homeModel.user;
    return Scaffold(
      appBar: AppBar(actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              //Criar logout -----------

              bloc.navigatorPop();
            },
          ),
        )
      ], automaticallyImplyLeading: false),
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
                      visible: homeModel.visibleFilter,
                      child: Column(
                        children: [
                          // ListTile(
                          //     title:
                          //         const Text("Linguagem de programação"),
                          //     trailing: Switch(
                          //         value: homeModel.filter!
                          //             .visibleProgrammingLanguage,
                          //         onChanged: (value) {
                          //           bloc
                          //               .setProgrammingLanguage(value);
                          //         })),
                          ListTile(
                              title: const Text("Localização do usuário"),
                              trailing: Switch(
                                  value: homeModel.filter!.visibleUserLocation,
                                  onChanged: (value) {
                                    bloc.setUserLocation(value);
                                  })),
                          ListTile(
                              title: const Text("Número de repositórios"),
                              trailing: Switch(
                                  value: homeModel
                                      .filter!.visibleNumberOfRepositories,
                                  onChanged: (value) {
                                    log(value.toString());
                                    bloc.setNumberOfRepositories(value);
                                  })),
                          ListTile(
                              title: const Text("Número de seguidores"),
                              trailing: Switch(
                                  value: homeModel
                                      .filter!.visibleNumberOfFollowers,
                                  onChanged: (value) {
                                    bloc.setNumberOfFollowers(value);
                                  })),
                          const Divider(
                            height: 32,
                          ),
                        ],
                      )),
                  LayoutBuilder(builder: (context, viewporConstraits) {
                    return ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: viewporConstraits.maxWidth),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              maxRadius: 40,
                              child: ClipOval(
                                child: Image.network(
                                  user?.avatarUrl ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      (user?.publicRepos ?? 0).toString(),
                                    ),
                                    const Text("repos"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text((user?.followers ?? 0).toString()),
                                    const Text("seguidores"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text((user?.following ?? 0).toString()),
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
                    user?.name ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  CustomLisTitle(subtitle: user?.login),
                  CustomLisTitle(
                    tite: "localização",
                    subtitle: user?.location,
                  ),
                  CustomLisTitle(tite: "email", subtitle: user?.email),
                  CustomLisTitle(
                    subtitle: user?.bio,
                  ),
                  CustomLisTitle(
                    tite: "blog",
                    subtitle: user?.blog,
                  ),
                  CustomLisTitle(
                    tite: "empresa",
                    subtitle: user?.company,
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
                      itemCount: homeModel.userReposModel.length,
                      itemBuilder: (context, index) {
                        final repos = homeModel.userReposModel[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        repos?.name ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
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
                                            (repos?.language ?? '').isNotEmpty,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 12,
                                              color: LinguageColor().getColor(
                                                  repos?.language ?? ''),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(repos?.language ?? ''),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        repos?.stargazersCount == 0
                                            ? Icons.star_border_rounded
                                            : Icons.star_rate_rounded,
                                        size: 16,
                                        color: repos?.stargazersCount == 0
                                            ? null
                                            : Colors.amber[200],
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(repos?.stargazersCount.toString() ??
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
          ],
        ),
      ),
    );
  }
}
