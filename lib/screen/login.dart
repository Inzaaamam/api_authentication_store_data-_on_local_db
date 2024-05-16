// ignore_for_file: sized_box_for_whitespace

import 'package:api_login/bloc/auth/auth_bloc.dart';
import 'package:api_login/bloc/auth/auth_event.dart';
import 'package:api_login/bloc/auth/auth_state.dart';
import 'package:api_login/screen/auth_sucess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FormGroup form = FormGroup({
    'username': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AuthSuccess(user: state.user),
              ),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16,150, 16, 16),
              child: ReactiveForm(
                formGroup: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: duplicate_ignore
                    // ignore: sized_box_for_whitespace
                    Container(
                      height: 120,
                      width: 120,
                      child: Image.network(
                          'https://robohash.org/Jeanne.png?set=set4'),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ReactiveTextField<String>(
              
                      formControlName: 'username',
                      decoration: InputDecoration(
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 1.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                          gapPadding: 100,
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: 'kminchelle',
                        labelText: 'Username',
                      ),
                      validationMessages: {
                        ValidationMessage.required: (error) =>
                            'Username is required',
                      },
                    ),
                    const SizedBox(height: 30),

                    ReactiveTextField<String>(
                      formControlName: 'password',
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade400, width: 1.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          labelText: 'Password',
                          hintText: "0lelplR"),
                      validationMessages: {
                        ValidationMessage.required: (error) =>
                            'Password is required',
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (form.valid) {
                                final username = form.control('username').value;
                                final password = form.control('password').value;
                                _loginBloc.add(
                                  PerformLoginEvent(username, password),
                                );
                              } else {
                                form.markAllAsTouched();
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue),
                              child: state is LoginLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      // color: Colors.white,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                      strokeWidth: 3,
                                    ))
                                  : const Center(
                                      child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('Continue With',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.black)),
                            GestureDetector(
                                onTap: () {
                                  // const username = 'kminchelle';
                                  // const password = '0lelplR';
                                  _loginBloc.add(
                                    GoogleLoginEvent('kminchelle', '0lelplR'),
                                  );
                                },
                                child: Text(" Google",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue[800],
                                        fontWeight: FontWeight.bold)))
                          ]),
                    ),
                    const SizedBox(height: 16.0),
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
              ),
            ),
          );
        }),
      ),
    );
  }
}
