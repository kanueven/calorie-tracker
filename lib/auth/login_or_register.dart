import 'package:calorie/pages/login.dart';
import 'package:calorie/pages/register.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});
  //add user
  // void addUser(String username,String password){
  //   final user = User()

  // }

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  //toggle pages
  void togglePages(){
    setState(() {
      showLoginPage =! showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return Login(onTap: togglePages);
    }else{
      return RegisterPage(onTap: togglePages);
    }

    
  }
}