import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void exportedBinds(i) {
    i.addLazySingleton<AuthBloc>(AuthBloc.new);
    i.addLazySingleton<IAuthLocalDatasource>(AuthLocalDatasource.new);
    i.addLazySingleton<IAuthRepository>(AuthRepository.new);
    i.addLazySingleton<IRetrieveLastSession>(RetrieveLastSession.new);
    super.exportedBinds(i);
  }

  @override
  void routes(r) {
    r.module(
      '/login',
      module: LoginModule(),
    );

    r.module(
      '/signup',
      module: SignupModule(),
    );
  }
}
