import 'package:flutter/material.dart';

class CustomLisTitle extends StatelessWidget {
  final String tite;
  final String? subtitle;

  const CustomLisTitle({
    super.key,
    this.tite = "",
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: subtitle != null && subtitle!.isNotEmpty,
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
