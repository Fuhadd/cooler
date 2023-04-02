// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccessfull extends LoginState {
  User? user;

  LoginSuccessfull({
    this.user,
  });
}

class LoginFailed extends LoginState {
  String message;
  LoginFailed(
    this.message,
  );

  @override
  List<Object> get props => [message];
}
