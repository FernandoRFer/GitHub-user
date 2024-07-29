class TokenModel {
  String accessToken;
  String scope;
  String tokenType;

  TokenModel(
      {required this.accessToken,
      required this.scope,
      required this.tokenType});

  TokenModel.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'] ?? "",
        scope = json['scope'] ?? "",
        tokenType = json['token_type'] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['scope'] = scope;
    data['token_type'] = tokenType;
    return data;
  }
}
