import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(i) {
    i.addLazySingleton<ISecureStorageAdapter>(() => FlutterSecureStorageAdapter());
    i.addLazySingleton<INavigationHandlerPresenter>(NavigationHandler.new);
    i.addLazySingleton<IAppNavigatorAdapter>(ModularNavigator.new);
    super.exportedBinds(i);
  }
}
