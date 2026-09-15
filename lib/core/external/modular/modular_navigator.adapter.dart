import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ModularNavigator implements IAppNavigatorAdapter {
  @override
  Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments}) {
    return Modular.to.pushNamed<T>(routeName, arguments: arguments);
  }

  @override
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return Modular.to.pushReplacementNamed<T, TO>(routeName, result: result, arguments: arguments);
  }

  @override
  void navigate(String routeName, {Object? arguments}) {
    Modular.to.navigate(routeName, arguments: arguments);
  }

  @override
  void pop<T extends Object?>([T? result]) {
    Modular.to.pop(result);
  }

  @override
  bool canPop() {
    return Modular.to.canPop();
  }
}
