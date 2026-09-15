import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Placeholder do módulo de cadastro. Binds e regras de negócio (use cases,
/// datasources, validações) serão adicionados na implementação completa.
class SignupModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child(
      SignupRoutes.root,
      child: (context) => const SignupPage(),
    );
  }
}
