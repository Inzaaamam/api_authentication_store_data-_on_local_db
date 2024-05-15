
import 'package:api_login/bloc/auth/auth_bloc.dart';
import 'package:api_login/bloc/auth/auth_event.dart';
import 'package:api_login/bloc/auth/auth_state.dart';
import 'package:api_login/screen/auth_sucess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}
class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
      // ignore: no_leading_underscores_for_local_identifiers
      final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,
        title: const Text('Login Screen', style: TextStyle(color: Colors.white),),),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AuthSuccess(user: state.user),
              ),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        _loginBloc.add(
                          PerformLoginEvent(
                            _usernameController.text,
                            _passwordController.text,
                          ),
                        );
                      },
                      child: const Text('Login'),
                    ),
                    if (state is LoginFailureState)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          state.errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
 }
}