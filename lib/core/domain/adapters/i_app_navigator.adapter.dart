abstract class IAppNavigatorAdapter {
  /// Navega para uma nova rota, empilhando-a sobre a atual.
  Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments});

  /// Substitui a rota atual pela nova rota informada.
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  });

  /// Navega para uma nova rota removendo toda a pilha de navegação anterior.
  void navigate(String routeName, {Object? arguments});

  /// Remove a rota atual da pilha, retornando à anterior.
  void pop<T extends Object?>([T? result]);

  /// Indica se é possível voltar para uma rota anterior na pilha atual.
  bool canPop();
}
