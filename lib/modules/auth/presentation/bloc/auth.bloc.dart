import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<IAuthEvent, IAuthState> {
  static AuthBloc get I => APP.I.serviceLocator.get<AuthBloc>();

  AuthBloc() : super(const AuthInitialState()) {
    on<RetrieveLastSessionEvent>(_onRetrieveLastSessionRequested);
  }

  Future<void> _onRetrieveLastSessionRequested(
    RetrieveLastSessionEvent event,
    Emitter<IAuthState> emit,
  ) async {
    await state.retrieveLastSession(emit);
  }

  Future<Session?> retrieveLastSession() async {
    if (!state.isProcessing) return state.session;
    final Future<IAuthState> whenResolved = stream.firstWhere(
      (state) => !state.isProcessing,
    );
    add(const RetrieveLastSessionEvent());
    return (await whenResolved).session;
  }
}
