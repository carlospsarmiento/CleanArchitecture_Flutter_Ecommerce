class CustomGenericException implements Exception {
  final String? message;

  CustomGenericException({this.message});
}

class CustomNetworkException implements Exception {
  final String? message;

  CustomNetworkException({this.message});
}

class CustomHttpException implements Exception {
  final int? statusCode;

  CustomHttpException({this.statusCode});
}

class CustomApiException implements Exception {
  final String? message;

  CustomApiException({this.message});
}

class SharedPreferencesException implements Exception {
  final String? message;

  SharedPreferencesException({this.message});
}