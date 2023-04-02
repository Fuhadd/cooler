// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignupEvent {
  File image;
  String email;
  String firstName;
  String lastName;
  String password;
  int employerNumber;

  SignUpButtonPressed({
    required this.image,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.employerNumber,
  });

  @override
  List<Object> get props => [];
}
