abstract class ProfileRepo {
  Future<void> createProfile({
    required String uid,
    required String name,
  });

  Future<Map<String, dynamic>> getProfile({
    required String uid,
  });

  Future<void> updateProfile({
    required String uid,
    required String name,
  });
}