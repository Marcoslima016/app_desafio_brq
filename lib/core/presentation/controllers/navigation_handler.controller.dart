import 'package:app_desafio_brq/lib.exports.dart';

class NavigationHandler implements INavigationHandlerPresenter {
  static NavigationHandler get I => APP.I.serviceLocator.get<NavigationHandler>();
  IAppNavigatorAdapter get navigator => APP.I.serviceLocator.get<IAppNavigatorAdapter>();

  const NavigationHandler();

  @override
  void navigateToAuthenticatedArea() => navigator.pushReplacementNamed(HomeRoutes.root);

  @override
  void navigateToLogin() => navigator.pushReplacementNamed(AuthRoutes.login);

  @override
  void navigateToSignupFromLogin() => navigator.pushNamed(AuthRoutes.signup);
}
