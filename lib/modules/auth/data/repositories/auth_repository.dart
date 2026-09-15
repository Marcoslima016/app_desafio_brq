import 'package:app_desafio_brq/lib.exports.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository(this._datasource);

  final IAuthLocalDatasource _datasource;

  @override
  Future<Session?> retrieveLastSession() async {
    final SessionDto? dto = await _datasource.getLastSession();
    return dto?.toEntity();
  }
}
