import 'package:app_desafio_brq/lib.exports.dart';

class RetrieveLastSessionHook {
  RetrieveLastSessionHook(this._retrieveLastSession);

  final Future<Session?> Function() _retrieveLastSession;

  Future<Session?> call() => _retrieveLastSession();
}
