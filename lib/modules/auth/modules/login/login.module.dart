import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Placeholder do módulo de login. Binds e regras de negócio (use cases,
/// datasources, validações) serão adicionados na implementação completa.
class LoginModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child(
      LoginRoutes.root,
      child: (context) => const LoginPage(),
    );
  }
}
