// auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'events.dart';
import 'states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {


    on<AppStarted>((event, emit) async {
      final user = _auth.currentUser;
      if (user != null) {
        emit(Authenticated(user.uid));
      } else {
        emit(Unauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {

      emit(AuthLoading());

      try {
        final userCred = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(Authenticated(userCred.user!.uid));
      } catch (e) {
        emit(Unauthenticated(message: e.toString()));
      }
    });

    on<LoggedOut>((event, emit) async {
      await _auth.signOut();
      emit(Unauthenticated());
    });
  }
}
