import '../domain.exports.dart';

abstract class IRetrieveLastSession {
  Future<Session?> call();
}

class RetrieveLastSession implements IRetrieveLastSession {
  RetrieveLastSession(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Session?> call() => _repository.retrieveLastSession();
}
