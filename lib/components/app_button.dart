import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton(this.text,
      {this.onPressed,
      super.key,
      this.colorText,
      this.reduceSize = false,
      this.icon});
  final String text;
  final Color? colorText;
  final void Function()? onPressed;
  final bool reduceSize;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
              Theme.of(context).bottomSheetTheme.backgroundColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          )),
      onPressed: onPressed,
      child: Container(
        child: icon == null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8.0),
                child: Center(
                  child: Text(text,
                      style: TextStyle(
                          color: colorText, fontWeight: FontWeight.bold)),
                ))
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(height: 30, child: icon!),
                  ),
                  const SizedBox(width: 10),
                  Text(text,
                      style: TextStyle(
                          color: colorText ??
                              Theme.of(context).scaffoldBackgroundColor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
      ),
    );
  }
}
