part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class UserLoginEvent extends LoginEvent{
  String username;
  String password;

  UserLoginEvent({required this.username, required this.password});
}

class LoginSessionCheckEvent extends LoginEvent{

}
