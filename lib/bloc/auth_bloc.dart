import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        await repository.register(event.email, event.password);
        emit(RegisterSuccess());
      } catch (_) {
        emit(AuthFailure('Registration failed'));
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        final success = repository.login(event.email, event.password);

        if (success) {
          emit(LoginSuccess());
        } else {
          emit(AuthFailure('Wrong email or password'));
        }
      } catch (_) {
        emit(AuthFailure('Login failed'));
      }
    });
  }
}
