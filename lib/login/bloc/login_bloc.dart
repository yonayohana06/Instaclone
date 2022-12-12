import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<SubmitLogin>((event, emit) async {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        emit(LoginLoading());
        formKey.currentState!.save();
        final firebase = FirebaseAuth.instance;

        await firebase
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((userCredential) {
          emit(LoginSuccesful());
        }).onError((error, stackTrace) {
          emit(LoginFailed(error.toString()));
        });
      }
    });
  }
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
}
