/// Rotas do [AuthModule] e de seus submódulos ([LoginModule], [SignupModule]),
/// já compostas com o ponto de montagem definido em [AppModule] (`/auth`).
class AuthRoutes {
  const AuthRoutes._();

  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
}
