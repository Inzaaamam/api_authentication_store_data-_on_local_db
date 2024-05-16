import 'package:api_login/bloc/auth/auth_bloc.dart';
import 'package:api_login/bloc/auth/auth_event.dart';
import 'package:api_login/bloc/auth/auth_state.dart';
import 'package:api_login/screen/auth_sucess.dart';
import 'package:api_login/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() { // Initialize the FFI
  // sqfliteFfiInit();
  // // Change the default factory to FFI implementation
  // databaseFactory = databaseFactoryFfi;

  runApp( const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc()..add(CheckLoginStatusEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginSuccessState) {
              return AuthSuccess(user: state.user);
            } else {
              return const LoginForm();
            }
          },
        ),
      ),
    );
  }
}
