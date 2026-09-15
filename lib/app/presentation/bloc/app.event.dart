part of 'app.bloc.dart';

sealed class IAppEvent {
  const IAppEvent();
}

final class InitializeAppEvent extends IAppEvent {
  const InitializeAppEvent();
}
