import 'package:flutter/material.dart';

import '../theme.exports.dart';

class ColorsDark implements IThemeColorsTokens {
  const ColorsDark();

  // Marca / gradiente principal (header de login, botão de entrar, tab ativa,
  // links e checkbox marcado)
  @override
  final Color primary = const Color(0xFF12A888);

  @override
  final Color primaryVariant = const Color(0xFFBFBB4A);

  @override
  final Color onPrimary = Colors.white;

  // Acento secundário (ícone "Acidentes Pessoais" e demais destaques roxo/índigo)
  @override
  final Color secondary = const Color(0xFF5C6BC0);

  @override
  Color get onSecondary => Colors.white;

  // Superfícies (card de login, cards de "Minha Familia"/"Contratados",
  // chips de categoria)
  @override
  final Color surface = const Color(0xFF1A1A24);

  @override
  Color get onSurface => Colors.white;

  // Fundo geral do app (tela Home e área inferior da tela de login)
  @override
  final Color background = const Color(0xff101010);

  @override
  final Color onBackground = const Color(0xffE4E4E4);

  @override
  Color get disable => const Color(0xFF4A4A4A);

  @override
  Color get onDisable => const Color(0xFF9A9A9A);

  // Bordas de input, placeholders, ícones neutros (bottom nav, estado vazio)
  @override
  Color get neutral => const Color(0xFF8A8A8A);

  // Containers das categorias de seguro em "Cotar e Contratar"
  @override
  Color get containerPrimary => const Color(0xFF3FA66B); // Residência (verde)

  @override
  Color get containerSecondary => const Color(0xFF29B6C8); // Automóvel (ciano)

  @override
  Color get containerTertiary => const Color(0xFFE05285); // Vida (rosa)

  @override
  Color get onContainer => Colors.white;
}

class ColorsLight implements IThemeColorsTokens {
  const ColorsLight();

  // Marca / gradiente principal (header de login, botão de entrar, tab ativa,
  // links e checkbox marcado) — tons um pouco mais escuros que no dark para
  // manter contraste sobre fundo claro
  @override
  final Color primary = const Color(0xFF0E9678);

  @override
  final Color primaryVariant = const Color(0xFFA6A23E);

  @override
  final Color onPrimary = Colors.white;

  // Acento secundário (ícone "Acidentes Pessoais" e demais destaques roxo/índigo)
  @override
  final Color secondary = const Color(0xFF4C56A8);

  @override
  Color get onSecondary => Colors.white;

  // Superfícies (card de login, cards de "Minha Familia"/"Contratados",
  // chips de categoria)
  @override
  final Color surface = const Color(0xFFFFFFFF);

  @override
  Color get onSurface => const Color(0xFF1A1A24);

  // Fundo geral do app (tela Home e área inferior da tela de login)
  @override
  final Color background = const Color(0xFFF7F7F9);

  @override
  final Color onBackground = const Color(0xFF1E1E1E);

  @override
  Color get disable => const Color(0xFFD0D0D0);

  @override
  Color get onDisable => const Color(0xFF9A9A9A);

  // Bordas de input, placeholders, ícones neutros (bottom nav, estado vazio)
  @override
  Color get neutral => const Color(0xFFB0B0B0);

  // Containers das categorias de seguro em "Cotar e Contratar"
  @override
  Color get containerPrimary => const Color(0xFF3FA66B); // Residência (verde)

  @override
  Color get containerSecondary => const Color(0xFF1DA6BC); // Automóvel (ciano)

  @override
  Color get containerTertiary => const Color(0xFFDB3E76); // Vida (rosa)

  @override
  Color get onContainer => Colors.white;
}
