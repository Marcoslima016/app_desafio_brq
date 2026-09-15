import '../entities/session.entity.dart';

abstract class IAuthRepository {
  Future<Session?> retrieveLastSession();
}
