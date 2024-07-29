import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_labs/core/theme/app_theme.dart';

class AppTextFormField extends StatefulWidget {
  final Color? textColor;
  final Color? borderSideColor;
  final String labelText;
  final Color? labelStyleColor;
  final Color? focusedBorderColor;
  final bool isPassword;
  final IconData? icon;
  final String? Function(String?)? validador;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool showCursor;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String?)? onFieldSubmitted;
  final TextInputAction? textInputAction;

  const AppTextFormField({
    this.borderSideColor,
    this.textColor,
    this.labelText = " ",
    this.labelStyleColor,
    this.focusedBorderColor,
    this.isPassword = false,
    this.icon,
    this.validador,
    this.onChanged,
    this.inputFormatters,
    this.controller,
    this.keyboardType,
    this.focusNode,
    super.key,
    this.showCursor = true,
    this.readOnly = false,
    this.onTap,
    this.onFieldSubmitted,
    this.textInputAction,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged ?? (value) {},
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      onFieldSubmitted: widget.onFieldSubmitted ?? (value) {},
      onTap: widget.onTap,
      textInputAction: widget.textInputAction,
      obscureText: passwordVisible,
      validator: widget.validador,
      inputFormatters: widget.inputFormatters,
      style: TextStyle(color: widget.textColor),
      decoration: InputDecoration(
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(kGlobalBorderRadiusInternal),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(kGlobalBorderRadiusInternal),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(kGlobalBorderRadiusInternal),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(kGlobalBorderRadiusInternal),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(kGlobalBorderRadiusInternal),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: widget.labelStyleColor),
          // border: OutlineInputBorder(borderRadius: BorderkGlobalBorderRadius),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    _setSenhaVisivel();
                  },
                  child: passwordVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off))
              : Icon(widget.icon)),
    );
  }

  void _setSenhaVisivel() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }
}

class AppFormText extends StatefulWidget {
  final Color? textColor;
  final Color? borderSideColor;
  final String labelText;
  final Color? labelStyleColor;
  final Color? focusedBorderColor;
  final bool isPassword;
  final IconData? icon;
  final String? Function(String?)? validador;
  final void Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLines;

  const AppFormText({
    this.borderSideColor,
    this.textColor,
    this.labelText = " ",
    this.labelStyleColor,
    this.focusedBorderColor,
    this.isPassword = false,
    this.icon,
    this.validador,
    this.onChanged,
    this.inputFormatters,
    this.controller,
    this.keyboardType,
    this.maxLines,
    super.key,
  });

  @override
  State<AppFormText> createState() => _AppFormTexteState();
}

class _AppFormTexteState extends State<AppFormText> {
  bool senhaVisivel = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged ?? (value) {},
      obscureText: senhaVisivel,
      validator: widget.validador,
      inputFormatters: widget.inputFormatters,
      style: TextStyle(color: widget.textColor),
      decoration: InputDecoration(
        // enabledBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(
        //       //  color: Color.fromARGB(0, 0, 0, 0),
        //       ),
        // ),
        labelText: widget.labelText,
        labelStyle: TextStyle(color: widget.labelStyleColor),
        // border: OutlineInputBorder(borderRadius: BorderkGlobalBorderRadius),
        // focusedBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(color: Color.fromARGB(0, 0, 0, 0), width: 1.0),
        // ),
      ),
    );
  }
}
