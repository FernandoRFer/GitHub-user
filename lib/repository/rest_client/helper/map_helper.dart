class MapHelper {
  static Map<String, String> mergeMaps(List<Map<String, String>?> pars) {
    Map<String, String>? finalHeaders;

    for (var element in pars) {
      if (element != null) {
        finalHeaders ??= <String, String>{};
        finalHeaders.addAll(element);
      }
    }

    return finalHeaders ?? {};
  }
}
