import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistic/src/extension/number_extension.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import '../../../api/api_repo/login_api_repo.dart';
import '../../../share_preference/sh_keys.dart';
import '../../../share_preference/sh_utils.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(status: LoginStatus.initial)) {
    on<UserLoginEvent>(_loginUser);
    on<LoginSessionCheckEvent>(_sessionCheck);
  }
  
  FutureOr<void> _loginUser(UserLoginEvent event, Emitter<LoginState> emit) async{
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await LoginApiRepo().loginProcess(
          name: event.username, password: event.password, db: "pd_db");
      emit(state.copyWith(status: LoginStatus.success));
    }on DioException catch(e){
      emit(state.copyWith(status: LoginStatus.fail));
    }on OdooException catch(e){
      emit(state.copyWith(status: LoginStatus.fail));
    }
    await Future.delayed(1.second);
    emit(state.copyWith(status: LoginStatus.initial));
  }

  FutureOr<void> _sessionCheck(LoginSessionCheckEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    String? sessionKey = await SharePrefUtils().getString(ShKeys.sessionKey);
    if(sessionKey != null){
      emit(state.copyWith(status: LoginStatus.success));
    }
    emit(state.copyWith(status: LoginStatus.fail));
    await Future.delayed(1.second);
    emit(state.copyWith(status: LoginStatus.initial));
  }
}
