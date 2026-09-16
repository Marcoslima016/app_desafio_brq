import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}

class APP {
  APP._privateConstructor();
  static final APP _instance = APP._privateConstructor();
  factory APP() => _instance;
  static APP get I => _instance;

  late final ThemeController themeController;
  late final INavigationHandlerPresenter navigationHandler;
  late final IServiceLocatorAdapter serviceLocator;
  late final BuildContext Function() globalContext;

  Future boot({BuildContext Function()? globalContextGetterFunction}) async {
    globalContextGetterFunction ??= () => Modular.routerDelegate.navigatorKey.currentContext!;
    globalContext = globalContextGetterFunction;
    serviceLocator = ModularServiceLocator();
    navigationHandler = serviceLocator.get<INavigationHandlerPresenter>();
    themeController = ThemeController(
      tokens: DesignSystemTokens(),
      storage: Modular.get<ILocalStorageAdapter>(),
    );
    await APP.I.themeController.initialize();
    AppBloc.I.add(const InitializeAppEvent());
  }
}
