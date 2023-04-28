class AccessTokenModel {
  final bool success;
  final String accessToken;

  AccessTokenModel({
    required this.success,
    required this.accessToken,
  });

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) {
    return AccessTokenModel(
      success: json['success'],
      accessToken: json['request_token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'request_token': accessToken,
  };
}