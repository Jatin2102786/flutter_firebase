// auth_state.dart
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}


class Authenticated extends AuthState {
  final String uid;
  Authenticated(this.uid);
}

class Unauthenticated extends AuthState {
  final String? message;
  Unauthenticated({this.message});
}
