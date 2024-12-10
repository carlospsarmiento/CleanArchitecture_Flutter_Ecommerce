/// Clase base para todas las fallas en el sistema.
abstract class Failure {
  final String? message;

  const Failure({this.message});
}

/// Falla causada por problemas de red (sin conexión, tiempo de espera, etc.).
class NetworkFailure extends Failure {
  const NetworkFailure({String? message}) : super(message: message ?? "No se pudo conectar con el servidor. Verifica tu conexión.");
}

/// Falla causada por errores en las respuestas HTTP del servidor.
class HttpFailure extends Failure {
  final int? statusCode;

  const HttpFailure({String? message, this.statusCode})
      : super(message: message ?? "Ocurrió un error en el servidor.");
}

/// Falla causada dentro de la API.
class ApiFailure extends Failure {
  const ApiFailure({String? message}) : super(message: message ?? "Ocurrió un error en el webservice.");
}

/// Falla causada por errores en el formato o parsing de datos.
class ParseFailure extends Failure {
  const ParseFailure({String? message}) : super(message: message ?? "Ocurrió un error al procesar la respuesta del servidor.");
}

/// Falla causada en Shared Preferences
class SharedPreferencesFailure extends Failure {
  const SharedPreferencesFailure({String? message}) : super(message: message ?? "Ocurrió un error al guardar las preferencias.");
}

/// Falla inesperada que no corresponde a las categorías anteriores.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({String? message}) : super(message: message ?? "Ocurrió un error inesperado.");
}
