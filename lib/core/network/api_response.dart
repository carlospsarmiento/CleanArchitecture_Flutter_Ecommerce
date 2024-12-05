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

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
      error: json['error'],
    );
  }
}
