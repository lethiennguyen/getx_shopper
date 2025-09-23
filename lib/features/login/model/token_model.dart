class ModelToken {
  final String token;

  ModelToken({
    required this.token,
  });

  factory ModelToken.fromJson(Map<String, dynamic> json) {
    return ModelToken(
      token: json['token']
    );
  }
}
