import 'package:http/http.dart' as http;
import '../../domain/entities/user.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Check for demo credentials
    if (request.email.toUpperCase() == 'ADMIN' && request.password == '12345678') {
      // Return mock successful response
      return LoginResponse(
        token: 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
        user: const User(
          id: '1',
          email: 'admin@lms.com',
          name: 'Administrator',
          role: 'admin',
        ),
      );
    } else {
      throw Exception('Invalid credentials');
    }

    // Uncomment below for real API integration
    /*
    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
    */
  }
}