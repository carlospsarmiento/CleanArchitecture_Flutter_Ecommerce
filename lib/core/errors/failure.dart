abstract class Failure {
  final String? message;

  const Failure({this.message});
}

class CustomGenericFailure extends Failure {
  const CustomGenericFailure({String? message}) : super(message: message ?? "Ocurrió un error.");
}