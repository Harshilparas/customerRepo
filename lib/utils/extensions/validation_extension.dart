import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Email validation

extension EmailValidation on String {
  bool isValidEmail() {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(this);
  }
}

/// Flutter Toast

/*extension FlutterToastExtension on BuildContext {
  void showAnimatedToast(
    String message, {
    Toast length = Toast.LENGTH_LONG,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,

  }) {
    Fluttertoast.showToast(
      msg: message,
       fontSize: 10,
      toastLength:length,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }
}*/

extension FlutterToastExtension on BuildContext {
  void showAnimatedToast(
      String message, {
        Toast length = Toast.LENGTH_LONG,
        ToastGravity gravity = ToastGravity.BOTTOM,
        Color backgroundColor = Colors.black,
        Color textColor = Colors.white,
      }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: length,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 15
    );
  }
}

// <--------- Validation for strong Password --------->  //
bool isStrongPassword(String password) {
  // Define regular expressions for each requirement
  final hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  final hasDigits = RegExp(r'[0-9]');
  final hasCapitalLetters = RegExp(r'[A-Z]');
  final hasSmallLetters = RegExp(r'[a-z]');

  // Check each requirement
  final specialCharsValid = hasSpecialCharacters.hasMatch(password);
  final digitsValid = hasDigits.hasMatch(password);
  final capitalLettersValid = hasCapitalLetters.hasMatch(password);
  final smallLettersValid = hasSmallLetters.hasMatch(password);

  // Ensure all requirements are met
  return specialCharsValid &&
      digitsValid &&
      capitalLettersValid &&
      smallLettersValid && password.length >= 8;
}
