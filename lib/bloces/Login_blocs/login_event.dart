part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
class FetchLogin extends LoginEvent{
  final String Email;
  final String password;
  FetchLogin({
    required this.Email,
    required this.password
});
}
