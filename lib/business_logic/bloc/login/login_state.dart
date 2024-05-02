part of 'login_bloc.dart';

enum LoginStatus{
  initial,
  loading,
  fail,
  success
}

class LoginState {

  LoginStatus status;

  LoginState({required this.status});

  LoginState copyWith({LoginStatus? status}){
    return LoginState(status: status ?? this.status);
  }

}
