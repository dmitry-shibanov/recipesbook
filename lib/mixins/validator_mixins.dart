class ValidatorMixins {
  String validateEmail(String value) {
    if (value.isEmpty ||
        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
      return 'The mail is not valid';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty || value.length < 10) {
      return 'The password should be more than 10 characters';
    }
    return null;
  }
}
