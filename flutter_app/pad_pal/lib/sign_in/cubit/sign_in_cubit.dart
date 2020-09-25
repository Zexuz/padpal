import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:pad_pal/authentication/models/fcmToken.dart';
import 'package:pad_pal/authentication/models/models.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(const SignInState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password, state.fcmToken]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
   try{
     emit(state.copyWith(
       password: password,
       status: Formz.validate([state.email, state.fcmToken, password]),
     ));
   }catch(e){
     print(e);
    }
  }

  void addFcmToken(String value) {
    final token = FcmToken.dirty(value ?? "");
    emit(state.copyWith(
      token: token,
      status: Formz.validate([state.email, state.password, token]),
    ));
  }

  Future<void> SignInDebug() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    _authenticationRepository.loginDebug();
    emit(state.copyWith(status: FormzStatus.submissionSuccess));
  }

  Future<void> SignInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signIn(
        email: state.email.value,
        password: state.password.value,
        fcmToken: state.fcmToken.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
