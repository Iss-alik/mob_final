class Validators {

  static String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }

  static String? minLength(String? value, {int length = 8}) {
    if (value != null && value.length < length) {
      return "Too short";
    }
    return null;
  }

  static String? onlyDigits(String? value) {
    if (value != null && int.tryParse(value) == null) {
      return "Only digits allowed";
    }
    return null;
  }

  static String? email(String? value) {
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (value != null && !emailRegex.hasMatch(value)) {
      return "Invalid email";
    }

    return null;
  }
}