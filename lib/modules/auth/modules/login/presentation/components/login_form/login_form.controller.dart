import 'package:flutter/cupertino.dart';

class LoginFormController {
  TextEditingController userInput = TextEditingController();
  TextEditingController passInput = TextEditingController();

  final Key formKey = const Key("login-form");
}
