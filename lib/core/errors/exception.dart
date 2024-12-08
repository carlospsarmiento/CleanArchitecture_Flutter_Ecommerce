class NetworkException implements Exception {
  final String? message;

  NetworkException({this.message});
}

class ParseException implements Exception {}

class HttpException implements Exception {
  final int? statusCode;

  HttpException({this.statusCode});
}

class ApiException implements Exception {
  final String? message;

  ApiException({this.message});
}