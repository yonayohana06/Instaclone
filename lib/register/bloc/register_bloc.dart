import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        emit(RegisterLoading());
        final auth = FirebaseAuth.instance;

        await auth
            .createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        )
            .then((value) {
          emit(RegisterSuccesful());
        }).onError((error, stackTrace) {
          emit(RegisterFailed(error.toString()));
        });
      }
    });
  }
  String? validateEmail(String? v) {
    if (v == null || v.isEmpty) {
      return 'Email required.';
    }
    return null;
  }

  String? validatePassword(String? v) {
    if (v == null || v.isEmpty) {
      return 'Password required.';
    }
    if (v.length < 8) {
      return 'Too short, password min 8 character';
    }
    return null;
  }

  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
}
