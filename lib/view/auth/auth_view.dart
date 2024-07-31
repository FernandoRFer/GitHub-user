import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_user/components/app_button.dart';
import 'package:github_user/components/bottom_sheet.dart';
import 'package:github_user/components/error_view.dart';
import 'package:github_user/components/loading.dart';
import 'package:github_user/core/helpers/global_error.dart';
import 'package:github_user/core/helpers/validator.dart';

import 'auth_bloc.dart';

class AuthView extends StatefulWidget {
  final IAuthBloc bloc;
  const AuthView(
    this.bloc, {
    super.key,
  });

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with Validator {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passordController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  bool _stayConnected = false;
  late StreamSubscription<AuthModelBloc> listenBloc;
  // final LocalAuthentication auth = LocalAuthentication();
  // final _SupportState _supportState = _SupportState.unknown;
  // bool? _canCheckBiometrics;
  // List<BiometricType>? _availableBiometrics;
  // final String _authorized = 'Not Authorized';

  // @override
  // void initState() {
  //   super.initState();
  //   auth.isDeviceSupported().then(
  //         (bool isSupported) => setState(() => _supportState = isSupported
  //             ? _SupportState.supported
  //             : _SupportState.unsupported),
  //       );
  // }

  @override
  void initState() {
    super.initState();
    widget.bloc.onFetchingData.listen((e) {
      _stayConnected = e.isStayConnected;
    }).onDone(() {
      log("teste disposer listen");
    });
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    _passordController.dispose();
    _userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, viewporConstraits) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewporConstraits.maxHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<AuthModelBloc>(
                stream: widget.bloc.onFetchingData,
                initialData: AuthModelBloc("Loading",
                    isLoading: false, isStayConnected: false),
                builder: (context, snapshot) {
                  if (!snapshot.hasError) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isLoading) {
                        return Center(
                            child: AnimatedLoading(
                          title: snapshot.data!.state,
                        ));
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
                                  widget.bloc.navigatePop();
                                },
                              ),
                            ]),
                      );
                    });
                  }

                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 48),
                            Image.asset(
                              "assets/images/github-octocat.1024x900.png",
                            ),
                            const SizedBox(height: 48),
                            // AppTextFormField(
                            //     labelText: "E-Mail",
                            //     controller: _userController,
                            //     icon: Icons.account_circle,
                            //     validador: userValidator),
                            // const SizedBox(height: 24),
                            // AppTextFormField(
                            //     labelText: "Senha",

                            //     controller: _passordController,
                            //     isPassword: true,
                            //     validador: passwordValidator),
                            // const SizedBox(height: 8),
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: TextButton(
                            //       onPressed: () {},
                            //       style: ButtonStyle(
                            //           shape: WidgetStateProperty.all(
                            //         const RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.all(
                            //               kGlobalBorderRadiusInternal),
                            //         ),
                            //       )),
                            //       child: const Text('Esqueci a senha',
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.w300))),
                            // ),
                            const SizedBox(height: 4),
                            AppOutlinedButton(
                              "Authentication",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await widget.bloc.loginWeb();
                                }
                              },
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  "Do you want to stay connected?",
                                ),
                                Checkbox(
                                    value: _stayConnected,
                                    onChanged: (value) {
                                      widget.bloc.stayConnected();
                                    }),
                              ],
                            ),
                          ],
                        ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     const Divider(
                        //       height: 1,
                        //       thickness: 1,
                        //     ),
                        //     Row(
                        //       mainAxisSize: MainAxisSize.min,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         const Text('Não tem uma conta? '),
                        //         TextButton(
                        //             onPressed: () {
                        //               widget.bloc.navigateToRegister();
                        //             },
                        //             style: ButtonStyle(
                        //                 shape: WidgetStateProperty.all(
                        //               const RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.all(
                        //                     kGlobalBorderRadiusInternal),
                        //               ),
                        //             )),
                        //             child: const Text(
                        //               'Cadastre-se',
                        //             ))
                        //       ],
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      );
    }));
  }
}
//   Future<void> _checkBiometrics() async {
//     late bool canCheckBiometrics;
//     try {
//       canCheckBiometrics = await auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       canCheckBiometrics = false;
//       print(e);
//     }
//     if (!mounted) {
//       return;
//     }

//     setState(() {
//       _canCheckBiometrics = canCheckBiometrics;
//     });
//   }

//   Future<void> _getAvailableBiometrics() async {
//     late List<BiometricType> availableBiometrics;
//     try {
//       availableBiometrics = await auth.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       availableBiometrics = <BiometricType>[];
//       print(e);
//     }
//     if (!mounted) {
//       return;
//     }

//     setState(() {
//       _availableBiometrics = availableBiometrics;
//     });
//   }

//   Future<void> _authenticate() async {
//     bool authenticated = false;
//     try {
//       setState(() {
//         _isAuthenticating = true;
//         _authorized = 'Authenticating';
//       });
//       authenticated = await auth.authenticate(
//         localizedReason: 'Let OS determine authentication method',
//         options: const AuthenticationOptions(
//           stickyAuth: true,
//         ),
//       );
//       if (authenticated) {
//         Modular.to.pushNamed(AppRoutes.home);
//       }

//       setState(() {
//         _isAuthenticating = false;
//       });
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         _isAuthenticating = false;
//         _authorized = 'Error - ${e.message}';
//       });
//       return;
//     }
//     if (!mounted) {
//       return;
//     }

//     setState(
//         () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
//   }

//   Future<void> _authenticateWithBiometrics() async {
//     bool authenticated = false;
//     try {
//       setState(() {
//         _isAuthenticating = true;
//         _authorized = 'Authenticating';
//       });
//       authenticated = await auth.authenticate(
//         localizedReason:
//             'Scan your fingerprint (or face or whatever) to authenticate',
//         options: const AuthenticationOptions(
//           stickyAuth: true,
//           biometricOnly: true,
//         ),
//       );

//       setState(() {
//         _isAuthenticating = false;
//         _authorized = 'Authenticating';
//       });
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         _isAuthenticating = false;
//         _authorized = 'Error - ${e.message}';
//       });
//       return;
//     }
//     if (!mounted) {
//       return;
//     }

//     final String message = authenticated ? 'Authorized' : 'Not Authorized';
//     setState(() {
//       _authorized = message;
//     });
//   }

//   Future<void> _cancelAuthentication() async {
//     await auth.stopAuthentication();
//     setState(() => _isAuthenticating = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plugin example app'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.only(top: 30),
//         children: <Widget>[
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 AppTextButton(
//                   'Iniciar',
//                   onPressed: _authenticate,
//                 ),
//                 // if (_supportState == _SupportState.unknown)
//                 //   const AnimateLoading()
//                 // else if (_supportState == _SupportState.supported)
//                 //   const Text('This device is supported')
//                 // else
//                 //   const Text('This device is not supported'),
//                 // const Divider(height: 100),
//                 // Text('Can check biometrics: $_canCheckBiometrics\n'),
//                 // ElevatedButton(
//                 //   onPressed: _checkBiometrics,
//                 //   child: const Text('Check biometrics'),
//                 // ),
//                 // const Divider(height: 100),
//                 // Text('Available biometrics: $_availableBiometrics\n'),
//                 // ElevatedButton(
//                 //   onPressed: _getAvailableBiometrics,
//                 //   child: const Text('Get available biometrics'),
//                 // ),
//                 // const Divider(height: 100),

//                 // if (_isAuthenticating)
//                 //   ElevatedButton(
//                 //     onPressed: _cancelAuthentication,
//                 //     // TODO(goderbauer): Make this const when this package requires Flutter 3.8 or later.
//                 //     // ignore: prefer_const_constructors
//                 //     child: Row(
//                 //       mainAxisSize: MainAxisSize.min,
//                 //       children: const <Widget>[
//                 //         Text('Cancel Authentication'),
//                 //         Icon(Icons.cancel),
//                 //       ],
//                 //     ),
//                 //   )
//                 // else
//                 //   Column(
//                 //     children: <Widget>[
//                 //       ElevatedButton(
//                 //         onPressed: _authenticate,
//                 //         // TODO(goderbauer): Make this const when this package requires Flutter 3.8 or later.
//                 //         // ignore: prefer_const_constructors
//                 //         child: Row(
//                 //           mainAxisSize: MainAxisSize.min,
//                 //           children: const <Widget>[
//                 //             Text('Authenticate'),
//                 //             Icon(Icons.perm_device_information),
//                 //           ],
//                 //         ),
//                 //       ),
//                 //       ElevatedButton(
//                 //         onPressed: _authenticateWithBiometrics,
//                 //         child: Row(
//                 //           mainAxisSize: MainAxisSize.min,
//                 //           children: <Widget>[
//                 //             Text(_isAuthenticating
//                 //                 ? 'Cancel'
//                 //                 : 'Authenticate: biometrics only'),
//                 //             const Icon(Icons.fingerprint),
//                 //           ],
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// enum _SupportState {
//   unknown,
//   supported,
//   unsupported,
// }
