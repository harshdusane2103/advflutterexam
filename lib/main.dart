import 'package:advflutterexam/Services/Auth_services.dart';
import 'package:advflutterexam/View/Auth/auth.dart';
import 'package:advflutterexam/View/Home/home.dart';
import 'package:advflutterexam/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

   Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
    }

    class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
    return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: (AuthServices.userServices.getCurrentUser()!= null)
    ?  HomeScreen()
        : const SingInScreen(),
    );
    }
    }