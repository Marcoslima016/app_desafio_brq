import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ModularServiceLocator implements IServiceLocatorAdapter {
  @override
  B get<B extends Object>({String? key}) {
    return Modular.get<B>(key: key);
  }

  @override
  void replaceInstance<T>(T instance, {String? key}) {
    Modular.replaceInstance<T>(instance, key: key);
  }
}
