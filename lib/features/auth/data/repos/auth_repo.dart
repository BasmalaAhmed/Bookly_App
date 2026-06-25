abstract class AuthRepo {
  Future<void> registerUser({
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
}