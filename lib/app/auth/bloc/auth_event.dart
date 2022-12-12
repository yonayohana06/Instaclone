part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class CheckAuth extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LogOut extends AuthEvent {
  @override
  List<Object?> get props => [];
}
