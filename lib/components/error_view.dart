import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget>? buttons;
  final bool enableDrag = false;

  const ErrorView({
    super.key,
    this.title = "",
    this.subtitle = "",
    this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: const TextStyle(
                      color: Colors.red,
                    )),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: SingleChildScrollView(
                    child: Text(subtitle, style: const TextStyle()),
                  ),
                ),
                const SizedBox(height: 55),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [...buttons ?? []],
            ),
          ),
        ],
      ),
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
