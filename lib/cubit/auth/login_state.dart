abstract class AuthState {}

class LoginedState extends AuthState {}

class LoginedUPDState extends AuthState {}

class LogoutedState extends AuthState {}

class ForgotPasswordState extends AuthState {}

class ErrorState extends AuthState {
  final String message;
  ErrorState(this.message);
}

class EmptyState extends AuthState {}
