
abstract class AuthenticationRepository {

  Future<Map<String, dynamic>> signup(
    String username,
    String firstName,
    String lastName,
    String country,
    String dateOfBirth,
    String email,
    String password,
  );

  Future<Map<String, dynamic>> login(
    String email,
    String password,
  );
}
