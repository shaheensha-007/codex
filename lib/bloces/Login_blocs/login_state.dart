part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginblocLoading extends LoginState{}
class LoginblocLoaded extends LoginState{
  final LoginModel loginModel;
  LoginblocLoaded({required this.loginModel});
}
class LoginblocError extends LoginState{
  final String Errormessage;
  LoginblocError({required this.Errormessage});
}
