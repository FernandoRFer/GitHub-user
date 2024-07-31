import 'dart:convert';

import 'package:flutter/services.dart';

abstract class ILinguageColor {
  Color? getColor(String linguage);
  Future<void> initList();
}

class LinguageColor implements ILinguageColor {
  Map<String, String?>? _wordList;

  static final LinguageColor instance = LinguageColor._();
  factory LinguageColor() {
    return instance;
  }
  LinguageColor._();

  @override
  Color? getColor(String linguage) {
    Color? color;
    if (_wordList != null && _wordList!.containsKey(linguage)) {
      color = HexColor.fromHex(_wordList![linguage]!);
    }
    return color;
  }

  @override
  Future<void> initList() async {
    Map<String, String?> colors = {};
    final String jsonString =
        await rootBundle.loadString('assets/theme/colors.json');
    final Map<dynamic, dynamic> data = jsonDecode(jsonString);

    data.forEach((key, value) {
      String? color = value["color"];
      colors.addAll({key: color});
    });
    _wordList = colors;
  }

  String capitalize(String value) {
    if (value.trim().isEmpty) return "";
    return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
