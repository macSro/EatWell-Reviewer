class Tools {
  static String getImageName(String val) {
    return val.replaceAll(RegExp(' +'), '-').toLowerCase() + '.jpg';
  }

  static String getDate(DateTime date) {
    String day = date.day < 10 ? '0${date.day}' : '${date.day}';
    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    return '$day-$month-${date.year}';
  }

  static String validatePassword(String val) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);

    return val.isEmpty
        ? 'Enter a password.'
        : val.length < 8
            ? 'Password must contain at least 8 characters.'
            : !regExp.hasMatch(val)
                ? 'At least 1: uppercase, lowercase, special character & digit.'
                : null;
  }

  static String validateEmail(String val) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(val) ? null : 'Enter a valid e-mail.';
  }
}
