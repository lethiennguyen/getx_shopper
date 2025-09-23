class BaseResponse<T> {
  BaseResponse({
    required this.success,
    required this.message,
    required this.data,
  });
  final bool success;
  final String message;
  final T? data;


  factory BaseResponse.fromJson(
      Map<String, dynamic> json, {
        T Function(Map<String, dynamic> x)? func,
      }) {
    T? convertObject() => func != null ? func(json['data']) : json['data'];
    return BaseResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: json['data'] != null ? convertObject() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
  };
}