abstract class AuthRepo {
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  });

  Future<void> loginUser({required String email, required String password});

  Future<void> resetPassword({required String email});

  Future<String?> getCurrentUserEmail();

  Future<void> changeEmail({
    required String newEmail,
    required String password,
  });

  Future<void> savePendingEmail(String email);

  Future<String?> getPendingEmail();

  Future<void> clearPendingEmail();

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<void> deleteAccount({required String password});

  Future<void> logout();

  Future<bool> isUserLoggedIn();
}
