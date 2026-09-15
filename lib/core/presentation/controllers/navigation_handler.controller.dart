import 'package:app_desafio_brq/lib.exports.dart';

class NavigationHandler implements INavigationHandlerPresenter {
  static NavigationHandler get I => APP.I.serviceLocator.get<NavigationHandler>();
  IAppNavigatorAdapter get _navigator => APP.I.serviceLocator.get<IAppNavigatorAdapter>();

  const NavigationHandler();

  @override
  void navigateToAuthenticatedArea() => _navigator.pushReplacementNamed(HomeRoutes.root);

  @override
  void navigateToLogin() => _navigator.pushReplacementNamed(AuthRoutes.login);

  @override
  void navigateToSignupFromLogin() => _navigator.pushNamed(AuthRoutes.signup);
}
