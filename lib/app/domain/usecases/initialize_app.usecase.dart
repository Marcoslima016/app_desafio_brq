import 'package:app_desafio_brq/lib.exports.dart';

abstract class IInitializeApp {
  Future<void> call(RetrieveLastSessionHook retrieveLastSessionHook);
}

class InitializeApp implements IInitializeApp {
  final INavigationHandlerPresenter _navigationHandler;
  const InitializeApp(this._navigationHandler);

  @override
  Future<void> call(RetrieveLastSessionHook retrieveLastSessionHook) async {
    try {
      Session? lastAuthSession = await retrieveLastSessionHook();
      bool userAuthenticated = lastAuthSession != null;

      if (!userAuthenticated) {
        _navigationHandler.navigateToLogin();
      } else {
        _navigationHandler.navigateToAuthenticatedArea();
      }
    } catch (_) {
      rethrow;
    }
  }
}
