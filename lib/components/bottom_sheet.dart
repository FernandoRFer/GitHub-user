import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_user/core/theme/app_theme.dart';

extension BottomSheetHelper on ScaffoldState {
  Future<bool?> bottomSheetCustom({
    required Widget child,
    required bool isDismissible,
    bool enableDrag = false,
  }) async {
    return await showModalBottomSheet<bool>(
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(kGlobalBorderRadiusExternal),
      ),
      builder: ((context) {
        return SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 4,
                    child: Container(),
                  ),
                  const Flexible(
                      flex: 2,
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey,
                      )),
                  Flexible(
                    flex: 4,
                    child: Container(),
                  ),
                ],
              ),
              child,
            ],
          ),
        );
      }),
    );
  }

  // Future<bool?> showSuccess(
  //     {List<Widget>? buttons, required BuildContext context}) async {
  //   return await showModalBottomSheet<bool>(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(5.0),
  //     ),
  //     builder: ((context) {
  //       return const SuccessView();
  //     }),
  //   );
  // }
}
// Future<bool?> showBottomCounter({
//   String title = "",
//   String subtitle = "",
//   required BuildContext context,
// }) async {
//   return await showModalBottomSheet<bool>(
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(5.0),
//     ),
//     builder: ((context) {
//       return CounterModalBottomSheet(
//         title: title,
//         subtitle: subtitle,
//       );
//     }),
//   );
// }

// Future<bool?> showBottomSheetOptions(
//     {String title = "",
//     String subtitle = "",
//     required BuildContext context}) async {
//   return await showModalBottomSheet<bool>(
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(5.0),
//     ),
//     builder: ((context) {
//       return SizedBox(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               children: [
//                 Flexible(
//                   flex: 4,
//                   child: Container(),
//                 ),
//                 const Flexible(
//                     flex: 2,
//                     child: Divider(
//                       thickness: 2,
//                       color: AppTheme.greyColor,
//                     )),
//                 Flexible(
//                   flex: 4,
//                   child: Container(),
//                 ),
//               ],
//             ),
//             AppScreenPadding(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   AppText(
//                     title,
//                     fontSize: AppFontSize.heading4,
//                     fontColor: AppColor.purple,
//                     align: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   AppText(
//                     subtitle,
//                     fontSize: AppFontSize.heading5,
//                     // fontColor: AppColor.purple,
//                     align: TextAlign.center,
//                   ),
//                   const SizedBox(height: 26),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Flexible(
//                           flex: 3,
//                           child: AppOutlinedButton(
//                             AppLocalizations.of(context)!.translate("No"),
//                             onPressed: () => Navigator.of(context).pop(false),
//                           )),
//                       const Flexible(
//                         flex: 1,
//                         child: SizedBox(),
//                       ),
//                       Flexible(
//                           flex: 3,
//                           child: AppPrimaryButton(
//                             AppLocalizations.of(context)!.translate("Yes"),
//                             onPressed: () => Navigator.of(context).pop(true),
//                           ))
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     }),
//   );
// }

// Future<bool?> showBottomSheetInformation({
//   String title = "",
//   String subtitle = "",
//   AppColor color = AppColor.success,
//   List<Widget>? buttons,
//   required bool isDismissible,
//   required BuildContext context,
//   bool enableDrag = false,
// }) async {
//   return await showModalBottomSheet<bool>(
//     isDismissible: isDismissible,
//     enableDrag: enableDrag,
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(5.0),
//     ),
//     builder: ((context) {
//       return SizedBox(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               children: [
//                 Flexible(
//                   flex: 4,
//                   child: Container(),
//                 ),
//                 const Flexible(
//                     flex: 2,
//                     child: Divider(
//                       thickness: 2,
//                       color: AppTheme.greyColor,
//                     )),
//                 Flexible(
//                   flex: 4,
//                   child: Container(),
//                 ),
//               ],
//             ),
//             AppScreenPadding(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   AppText(
//                     title,
//                     fontSize: AppFontSize.heading4,
//                     fontColor: color,
//                     align: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   ConstrainedBox(
//                     constraints: const BoxConstraints(maxHeight: 250),
//                     child: SingleChildScrollView(
//                       child: AppText(
//                         subtitle,
//                         fontSize: AppFontSize.heading5,
//                         // fontColor: AppColor.purple,
//                         align: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 26),
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [...buttons ?? []],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     }),
//   );
// }
