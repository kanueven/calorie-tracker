import 'package:calorie/main.dart';
import 'package:calorie/objectbox.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/objectbox.dart';
import '../model/user.dart';

class AuthState extends ChangeNotifier{
   final ObjectBox objectBox; // Injected ObjectBox instance

  AuthState(this.objectBox); 
  //private variables
   // Shared fields
  String _username = '';
  String _password = '';
  
  // Registration-specific fields
  
  String _confirmPassword = '';

  bool _isLoggedIn = false;

  //getters
  String get username => _username;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  bool get isLoggedIn => _isLoggedIn;

  //setters
  void setUsername(String username){
    _username = username;
    notifyListeners();
  }
  void setPassword(String password){
    _password = password;
    notifyListeners();
  }
  void setConfirmPassword(String confirmPassword){
    _confirmPassword = confirmPassword;
    notifyListeners();
  }
  //authentification logic
  // Authentication logic
  void login() {
    //objectBox query
    Query<User> query = objectBox.userBox.query(
      User_.username.equals(username)
      .and(User_.password.equals(_password)),
    ).build();
    //there should only be one match
    _isLoggedIn = query.find().length == 1;
    query.close();
    //noftiy state
    notifyListeners();

   
  }


  void register(){
    bool passwordValid = _password.isNotEmpty;
    bool confirmPasswordValid = _confirmPassword.isNotEmpty && _confirmPassword ==_password;
    if(username.isNotEmpty &&passwordValid &&confirmPasswordValid){
      //check whether another username exists
      Query<User> query = objectBox.userBox.query(
        User_.username.equals(username),
      ).build();
      bool usernameExists = query.find().isNotEmpty;
      //always close your queries
      query.close();
      if(usernameExists){
        //alert them that they should find another username
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Username exists...use another name')),
        // );
        print("username exists");

      }else{
        //create a new user
        User newUser = User(username: username, password: _password);
        //update database
        objectBox.userBox.put(newUser);

        _isLoggedIn = true;
        notifyListeners();

      }
      
    }
  }



  
}