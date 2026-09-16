import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Placeholder da tela de login. Implementação completa (form, validação,
/// integração com [AuthBloc]) será feita posteriormente.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colors.background,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildBanner(),
        FormContainer(),
      ],
    );
  }

  Widget _buildBanner() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 0.5.sh,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.theme.colors.primary,
              context.theme.colors.primaryVariant,
            ],
          ),
        ),
      ),
    );
  }
}
