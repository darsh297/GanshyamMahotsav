class ValidationsFunction {
  static (String?, bool) emailValidation(String userInput) {
    if (RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(userInput)) {
      return (null, true);
    } else {
      return (userInput != '' ? "Please Enter valid Email Id" : "Field can not be empty", false);
    }
  }

  static (String?, bool) passwordValidation(String userInput) {
    if (RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$').hasMatch(userInput)) {
      return (null, true);
    } else {
      return (userInput != '' ? "Please Enter Password 8 character long, 1 special and 1 in uppercase" : "Field can not be empty", false);
    }
  }

  static (String?, bool) loginPasswordValidation(String userInput) {
    if (userInput.isNotEmpty) {
      return (null, true);
    } else {
      return ("Field can not be empty", false);
    }
  }

  static (String?, bool) phoneValidation(String userInput) {
    if (userInput == '') {
      return ('Field can not be empty', false);
    } else if (userInput.length != 10) {
      return ("Enter 10 digit number", false);
    } else if (RegExp(r'(^(?:[+0]9)?[0-9]{10}$)').hasMatch(userInput)) {
      return (null, true);
    } else {
      return (userInput != '' ? "Please Enter valid phone number" : "Field can not be empty", false);
    }
  }

  static (String?, bool) textValidation(String userInput) {
    if (userInput != '') {
      return (null, true);
    } else {
      return ("Field can not be empty", false);
    }
  }

  static (String?, bool) nameValidation(String userInput) {
    if (userInput.isEmpty) {
      return ("Field can not be empty", false);
    } else if (!RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(userInput)) {
      return ("Enter valid name", false);
    } else {
      return (null, true);
    }
  }

  static (String?, bool) dropdownValidation(String userInput) {
    if (!userInput.contains('Select')) {
      return (null, true);
    } else {
      return ("Select value from dropdown value", false);
    }
  }
}
