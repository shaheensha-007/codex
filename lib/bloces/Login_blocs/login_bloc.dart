import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:codex/Apies/LoginApies/LOginApies.dart';
import 'package:codex/Modelclass/Loginmodel/LoginModel.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    LogininApi loginApi=LogininApi();
    on<FetchLogin>((event, emit) async{
      emit(LoginblocLoading());
      try{
        final islogin=await loginApi.postLogindata(event.Email, event.password,);
        emit(LoginblocLoaded(loginModel: islogin));
      }
      catch(e){
        emit(LoginblocError(Errormessage: e.toString()));
      }
      // TODO: implement event handler
    });
  }
}
