abstract class AuthRepo {
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  });

  Future<void> loginUser({
    required String email,
    required String password,
  });

  Future<void> resetPassword({
    required String email,
  });

  Future<void> logout();

  Future<bool> isUserLoggedIn();
}