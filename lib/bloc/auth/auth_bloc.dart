// BLoC for login
import 'package:api_login/bloc/auth/auth_event.dart';
import 'package:api_login/bloc/auth/auth_state.dart';
import 'package:api_login/postdata/database.dart';
import 'package:api_login/postdata/model_class.dart';
import 'package:api_login/screen/api_service.dart';
import 'package:bloc/bloc.dart';

// BLoC for login
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
        emit(LoginSuccessState(user));
      } catch (error) {
        emit(LoginFailureState(error.toString()));
      }
    });
  }
}
