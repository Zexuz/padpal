import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:pad_pal/authentication/models/models.dart';
import 'package:pad_pal/authentication/models/name.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.email, username]),
    ));
  }

  void firstNameChanged(String value) {
    final firstName = Name.dirty(value);
    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([state.email, firstName]),
    ));
  }

  void lastNameChanged(String value) {
    final lastName = Name.dirty(value);
    emit(state.copyWith(
      lastName: lastName,
      status: Formz.validate([state.email, lastName]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.register(
        username: state.username.value,
        email: state.email.value,
        password: state.password.value,
        firstName: state.firstName.value,
        lastName: state.firstName.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
