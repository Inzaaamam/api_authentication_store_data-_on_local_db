// ignore_for_file: annotate_overrides

import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable { // Equatable is from the package 'equatable'
  @override
  List<Object> get props => [];
}
class PerformLoginEvent extends LoginEvent {
  final String username;
  final String password;

  PerformLoginEvent(this.username, this.password);
  List<Object> get props => [username , password];
}
