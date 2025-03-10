import 'package:flutter/material.dart';
import 'package:mediclic/pages/home_page.dart';
import 'package:mediclic/pages/login_page.dart';
import 'package:mediclic/services/auth.dart';

class RedirectionPage extends StatefulWidget {
  const RedirectionPage({super.key});

  @override
  State<RedirectionPage> createState() => _RedirectionPageState();
}

class _RedirectionPageState extends State<RedirectionPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges, 
      builder:(context ,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        } else if(snapshot.hasData){
          return const MyHomePage(title:  "Home page");
        }else {
          return const  LoginPage (title: "LoginPage");
        }
      }
      );
  }
}