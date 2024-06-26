// ignore_for_file: annotate_overrides

import 'package:equatable/equatable.dart';
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class PerformLoginEvent extends LoginEvent {
  final String username;
  final String password;
  PerformLoginEvent(this.username, this.password);
  @override
  List<Object> get props => [username, password];
}
class GoogleLoginEvent extends LoginEvent {
  final String username;
  final String password;
  GoogleLoginEvent(this.username, this.password);
  @override
  List<Object> get props => [username, password];
}
class PerformLogoutEvent extends LoginEvent {}

class CheckLoginStatusEvent extends LoginEvent {}