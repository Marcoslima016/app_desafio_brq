part of 'auth.bloc.dart';

sealed class IAuthEvent {
  const IAuthEvent();
}

final class RetrieveLastSessionEvent extends IAuthEvent {
  const RetrieveLastSessionEvent();
}
