import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app.event.dart';
part 'app.state.dart';

class AppBloc extends Bloc<IAppEvent, IAppState> {
  static AppBloc get I => APP.I.serviceLocator.get<AppBloc>();

  AppBloc() : super(const AppInitialState()) {
    on<InitializeAppEvent>(_onInitializeRequested);
  }

  Future<void> _onInitializeRequested(
    InitializeAppEvent event,
    Emitter<IAppState> emit,
  ) async {
    await state.initializeApp(emit);
  }
}
