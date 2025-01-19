class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool success;
  final dynamic error;

  ApiResponse({
    this.data,
    this.message,
    required this.success,
    this.error,
  });

  /*
  factory ApiResponse.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      //data: json['data'],
      data: json["data"]!=null? create(json["data"]): null,
      error: json['error'],
    );
  }
  */
  factory ApiResponse.fromJson(Map<String, dynamic> json, Function create) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      //data: json['data'],
      data: json["data"]!=null? create(json["data"]): null,
      error: json['error'],
    );
  }
}
