import 'package:flutter/foundation.dart';

class AuthState extends ChangeNotifier{
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

    // Example logic: Check username and password
    if (_username == "rae" && _password == "1234") {
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  void register() {
    // Example logic: Validate registration fields
    if (_password == _confirmPassword  && _username.isNotEmpty) {
      _isLoggedIn = true; // Automatically login user after registration
      notifyListeners();
    }
  }



  
}