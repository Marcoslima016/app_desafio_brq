part of 'app.bloc.dart';

// ---------------------------------------------------------------------------
// Estado base
// ---------------------------------------------------------------------------

sealed class IAppState {
  const IAppState();

  Future<void> initializeApp(Emitter<IAppState> emit);
}

// ---------------------------------------------------------------------------
// AppInitialState
// ---------------------------------------------------------------------------

final class AppInitialState extends IAppState {
  const AppInitialState();

  @override
  Future<void> initializeApp(Emitter<IAppState> emit) async {
    emit(const AppInitializing());
    try {
      final RetrieveLastSessionHook retrieveLastSessionHook = RetrieveLastSessionHook(
        AuthBloc.I.retrieveLastSession,
      );
      final initializeAppUseCase = APP.I.serviceLocator.get<IInitializeApp>();
      await initializeAppUseCase.call(retrieveLastSessionHook);
      emit(const AppInitialized());
    } catch (error) {
      emit(AppInitializationFailure(error.toString()));
    }
  }
}

// ---------------------------------------------------------------------------
// AppInitializing
// ---------------------------------------------------------------------------

final class AppInitializing extends IAppState {
  const AppInitializing();

  @override
  Future<void> initializeApp(Emitter<IAppState> emit) async {}
}

// ---------------------------------------------------------------------------
// AppInitialized
// ---------------------------------------------------------------------------

final class AppInitialized extends IAppState {
  const AppInitialized();

  @override
  Future<void> initializeApp(Emitter<IAppState> emit) async {}
}

// ---------------------------------------------------------------------------
// AppInitializationFailure
// ---------------------------------------------------------------------------

final class AppInitializationFailure extends IAppState {
  const AppInitializationFailure(this.message);

  final String message;

  @override
  Future<void> initializeApp(Emitter<IAppState> emit) async {}

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppInitializationFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}
