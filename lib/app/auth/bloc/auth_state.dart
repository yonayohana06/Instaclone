part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccesful extends AuthState {
  final Users user;

  const AuthSuccesful(this.user);
  @override
  List<Object> get props => [user];
}

class AuthFailed extends AuthState {
  final String message;

  const AuthFailed(this.message);
  @override
  List<Object> get props => [message];
}

class AuthLoggedOut extends AuthState {
  @override
  List<Object> get props => [];
}
