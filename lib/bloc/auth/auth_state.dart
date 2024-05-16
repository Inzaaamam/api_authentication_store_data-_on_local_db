// States for login
import 'package:api_login/postdata/model_class.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}
class GoogleLoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final ModelClass user;

  LoginSuccessState(this.user);
}

class LoginFailureState extends LoginState {
  final String errorMessage;

  LoginFailureState(this.errorMessage);
}