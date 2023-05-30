class IsSuccess{
  final bool success;
  final bool data;

  const IsSuccess({
    required this.data,
    required this.success
  });

  factory IsSuccess.fromJson(Map<String, dynamic> json) {
    final bool success = json['success'];
    final bool data = json['data'];
    return IsSuccess(
        data: data,
        success: success
    );
  }
}