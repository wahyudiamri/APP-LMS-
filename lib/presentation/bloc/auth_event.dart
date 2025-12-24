import '../../data/models/login_request.dart';

abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final LoginRequest request;

  LoginRequested(this.request);
}

class LogoutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}