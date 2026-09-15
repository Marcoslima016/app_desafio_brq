abstract class IServiceLocatorAdapter {
  B get<B extends Object>({String? key});
  void replaceInstance<T>(T instance, {String? key});
}
