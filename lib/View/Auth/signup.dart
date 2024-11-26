
import 'package:advflutterexam/Controller/Auth/auth.dart';
import 'package:advflutterexam/View/Auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
              Text(
                'Sign Up',
                style:TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: controller.txtFirstName,
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.black45,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(9),
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Name',
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
                  ),
                ],
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
              SizedBox(
                height: 10,
              ),




              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  controller.signUp(
                      controller.txtEmail.text, controller.txtPassword.text);
                  controller.txtEmail.clear();
                  controller.txtPassword.clear();
                  controller.txtFirstName.clear();

                  Get.to(SignIn());


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
                    'SignUp',
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
                    'Already have account?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(SignIn());
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
