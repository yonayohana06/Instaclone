part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccesful extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String message;

  const RegisterFailed(this.message);
  @override
  List<Object> get props => [message];
}
