import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/app/app.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<CheckAuth>((event, emit) {
      emit(AuthLoading());

      final firebase = FirebaseAuth.instance;
      if (firebase.currentUser == null) {
        emit(const AuthFailed('User not Found'));
      } else {
        final usr = Users(
          email: firebase.currentUser!.email!,
          uid: firebase.currentUser!.uid,
        );
        emit(AuthSuccesful(usr));
      }
    });

    on<LogOut>((event, emit) async {
      emit(AuthLoading());
      final firebase = FirebaseAuth.instance;
      await firebase.signOut().then((value) {
        emit(AuthLoggedOut());
      });
    });
  }
}
