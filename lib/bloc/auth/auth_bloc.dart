import 'package:api_login/bloc/auth/auth_event.dart';
import 'package:api_login/bloc/auth/auth_state.dart';
import 'package:api_login/postdata/database.dart';
import 'package:api_login/postdata/model_class.dart';
import 'package:api_login/screen/api_service.dart';
import 'package:bloc/bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<PerformLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        ModelClass user = await ApiService.authenticate(
          event.username,
          event.password,
        );
        await SQLHelper.createItems(
          user.id!,
          user.username!,
          user.email!,
          user.firstName!,
          user.lastName!,
          user.gender!,
          user.image!,
          user.token!,
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setInt('userId', user.id!);

        emit(LoginSuccessState(user));
      } catch (error) {
        emit(LoginFailureState(error.toString()));
      }
    });

    on<PerformLogoutEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      await prefs.remove('userId');
      emit(LoginInitialState());
    });

    on<CheckLoginStatusEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? isLoggedIn = prefs.getBool('isLoggedIn');
      if (isLoggedIn == true) {
        int? userId = prefs.getInt('userId');
        if (userId != null) {
          List<Map<String, dynamic>> users = await SQLHelper.getItems();
          var userMap = users.firstWhere((user) => user['id'] == userId,);
          // ignore: unnecessary_null_comparison
          if (userMap != null) {
            ModelClass userModel = ModelClass.fromJson(userMap);
            emit(LoginSuccessState(userModel));
          } else {
            emit(LoginInitialState());
          }
        } else {
          emit(LoginInitialState());
        }
      } else {
        emit(LoginInitialState());
      }
    });
  }
}
