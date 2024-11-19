import 'package:advflutterexam/View/Home/home.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
class SingInScreen extends StatelessWidget {
  const SingInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sing With Google'),
          SizedBox(height: 20,),
          Center(child: GestureDetector(onTap:(){

            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
          },child: GoogleAuthButton())),
        ],
      ),
    );
  }
}
