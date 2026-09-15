import 'dart:convert';

import 'package:app_desafio_brq/lib.exports.dart';

abstract class IAuthLocalDatasource {
  Future<SessionDto?> getLastSession();
}

class AuthLocalDatasource implements IAuthLocalDatasource {
  AuthLocalDatasource(this._secureStorageAdapter);

  final ISecureStorageAdapter _secureStorageAdapter;

  static const String sessionKey = 'auth_session';

  @override
  Future<SessionDto?> getLastSession() async {
    final String? rawSession = await _secureStorageAdapter.read(key: sessionKey);
    if (rawSession == null) return null;

    return SessionDto.fromJson(jsonDecode(rawSession) as Map<String, dynamic>);
  }
}
