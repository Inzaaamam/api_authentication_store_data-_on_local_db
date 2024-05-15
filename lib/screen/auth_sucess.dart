import 'package:api_login/postdata/model_class.dart';
import 'package:flutter/material.dart';

class AuthSuccess extends StatelessWidget {
  final ModelClass user;

  const AuthSuccess({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.blue,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  },icon: const Icon(Icons.arrow_back_ios ,size: 16,
                  color: Colors.white,),),
                  // Image.network(user.image ?? ''),
                  const Spacer(flex: 1,),
                  Text('Welcome, ${user.username}',
                      style: const TextStyle(color: Colors.white)),
                     const  Spacer(flex: 2,),
                ],
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50,20,0),
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
                      const SizedBox(height: 10,),
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
