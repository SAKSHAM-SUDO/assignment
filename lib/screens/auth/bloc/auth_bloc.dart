import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialState()) {
    on<LoginEvent>(_login);
  }

  _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    bool isEmailValid =
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            .hasMatch(event.email);

    bool isPasswordValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(event.password);

    if (isEmailValid == false) {
      emit(const LoginErrorState('Enter valid Email'));
    } else if (isPasswordValid == false) {
      emit(const LoginErrorState('Enter valid password'));
    } else {
      emit(LoginSuccessState());
    }
  }
}
