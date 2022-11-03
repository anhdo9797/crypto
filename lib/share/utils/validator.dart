class AppValidator {
  AppValidator._();

  static isEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  static String? userName(String? value) {
    if (isEmpty(value)) return "username_empty";

    return null;
  }

  // ignore: slash_for_doc_comments
  /**
  * required password:
  * - should contain at least one upper case
  * - should contain at least one lower case
  * - should contain at least one digit
  * - should contain at least one Special character
   * - Must be at least 8 characters in length  
  */
  static String? password(String? value) {
    if (isEmpty(value)) return "password_empty";

    final passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (!passwordRegExp.hasMatch(value!)) {
      return "password_incorrect";
    }
    return null;
  }

  static String? email(String? value) {
    if (isEmpty(value)) return "email_empty";

    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(value!)) {
      return "email_incorrect";
    }
    return null;
  }
}
