class Validators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'El email no puede estar vacío';
    }

    // Expresión regular para validar emails
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Ingresa un email válido';
    }

    return null; // Retorna null si es válido
  }
}