part of 'auth.bloc.dart';

// ---------------------------------------------------------------------------
// Estado base
// ---------------------------------------------------------------------------

sealed class IAuthState {
  bool get isAuthenticated => this is AuthenticatedState;
  Session? get session => this is AuthenticatedState ? (this as AuthenticatedState).session : null;
  bool get isProcessing => this is AuthInitialState || this is RetrievingLastSession;

  const IAuthState();

  Future<void> retrieveLastSession(Emitter<IAuthState> emit);
}

// ---------------------------------------------------------------------------
// AuthInitialState
// ---------------------------------------------------------------------------

final class AuthInitialState extends IAuthState {
  const AuthInitialState();

  @override
  Future<void> retrieveLastSession(Emitter<IAuthState> emit) async {
    emit(const RetrievingLastSession());
    try {
      final Session? session = await APP.I.serviceLocator.get<IRetrieveLastSession>().call();
      if (session == null) {
        emit(const UnauthorizedState());
      } else {
        emit(AuthenticatedState(session));
      }
    } catch (error) {
      emit(RetrieveLastSessionFailure(error.toString()));
    }
  }
}

// ---------------------------------------------------------------------------
// RetrievingLastSession
// ---------------------------------------------------------------------------

final class RetrievingLastSession extends IAuthState {
  const RetrievingLastSession();

  @override
  Future<void> retrieveLastSession(Emitter<IAuthState> emit) async {}
}

// ---------------------------------------------------------------------------
// AuthenticatedState
// ---------------------------------------------------------------------------

final class AuthenticatedState extends IAuthState {
  const AuthenticatedState(this.session);

  @override
  final Session session;

  @override
  Future<void> retrieveLastSession(Emitter<IAuthState> emit) async {}

  @override
  bool operator ==(Object other) => identical(this, other) || other is AuthenticatedState && other.session == session;

  @override
  int get hashCode => session.hashCode;
}

// ---------------------------------------------------------------------------
// UnauthorizedState
// ---------------------------------------------------------------------------

final class UnauthorizedState extends IAuthState {
  const UnauthorizedState();

  @override
  Future<void> retrieveLastSession(Emitter<IAuthState> emit) async {}
}

// ---------------------------------------------------------------------------
// RetrieveLastSessionFailure
// ---------------------------------------------------------------------------

final class RetrieveLastSessionFailure extends IAuthState {
  const RetrieveLastSessionFailure(this.message);

  final String message;

  @override
  Future<void> retrieveLastSession(Emitter<IAuthState> emit) async {}

  @override
  bool operator ==(Object other) => identical(this, other) || other is RetrieveLastSessionFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}
