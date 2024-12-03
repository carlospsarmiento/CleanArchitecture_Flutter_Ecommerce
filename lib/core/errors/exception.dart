class NetworkException implements Exception {}

class ParseException implements Exception {}

class HttpException implements Exception {
  final int? statusCode;

  HttpException({this.statusCode});
}