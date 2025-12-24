import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  static const String _tokenKey = 'auth_token';

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await remoteDataSource.login(request);
    await sharedPreferences.setString(_tokenKey, response.token);
    return response;
  }

  @override
  Future<void> logout() async {
    await sharedPreferences.remove(_tokenKey);
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = sharedPreferences.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString(_tokenKey);
  }
}