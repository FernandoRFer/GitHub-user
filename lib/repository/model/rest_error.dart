class RestError {
  final String message;
  final String octicon;

  RestError.fromJson(Map<String, dynamic> json)
      : message = json['message'] ?? "",
        octicon = json['octicon'] ?? "";

  @override
  String toString() {
    return "Código: $octicon - Mensagem: $octicon";
  }
}
