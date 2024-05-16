import 'package:api_login/bloc/auth/auth_bloc.dart';
import 'package:api_login/bloc/auth/auth_event.dart';
import 'package:api_login/postdata/model_class.dart';
import 'package:api_login/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AuthSuccess extends StatelessWidget {
  final ModelClass user;
  const AuthSuccess({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Welcome, ${user.username}',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(PerformLogoutEvent());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginForm(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
            child: Container(
              // height: 200,
              width: double.maxFinite,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: NetworkImage(user.image ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Username: ${user.username}'),
                      Text('Email: ${user.email}'),
                      Text('First Name: ${user.firstName}'),
                      Text('Last Name: ${user.lastName}'),
                      Text('Gender: ${user.gender}'),
                      // Text('Token: ${user.token}'),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
