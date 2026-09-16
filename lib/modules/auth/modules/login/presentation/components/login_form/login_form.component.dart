import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Form(
        child: Column(
          children: [
            MTextInput(controller: TextEditingController()),
          ],
        ),
      ),
    );
  }
}
