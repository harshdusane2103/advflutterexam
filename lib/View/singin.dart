

import 'package:advflutterexam/Controller/AuthController.dart';
import 'package:advflutterexam/View/Home.dart';
import 'package:advflutterexam/View/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 200, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Sign In',
                  style:TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),



              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: controller.txtEmail,
                  cursorColor: Colors.black45,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(9),
                    prefixIcon: Icon(Icons.mail),
                    labelText: 'Phone or email',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xffC7C9D9),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),


              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: controller.txtPassword,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black45,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(9),
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.remove_red_eye),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xffC7C9D9),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(3.0),

                    child: Text(
                      "Forget Password?",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              GestureDetector(
                onTap: () {

                  controller.signIn(
                      controller.txtEmail.text, controller.txtPassword.text);
                  controller.txtEmail.clear();
                  controller.txtPassword.clear();



                  Get.snackbar(
                    'Sign in',
                    'Sign in Successfully',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                  Get.to(HomeScreen());

                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {

                      Get.offAll(SignupScreen());
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
