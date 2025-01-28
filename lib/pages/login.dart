import 'package:calorie/components/my_button.dart';
import 'package:calorie/components/my_textfield.dart';
import 'package:calorie/pages/homescreen.dart';
import 'package:calorie/provider/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function()?  onTap;
  const Login({super.key,required this.onTap}); // Fix constructor name to match the class

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //method to handle sign in
  void login(){
    print("Login button clicked");
    //handle the authentification
    final authState = Provider.of<AuthState>(context,listen:false);

     // Retrieve the entered username and password
    final username = usernameController.text;
    final password = passwordController.text;

     // Check if fields are not empty
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }
    // Set the username and password in the AuthState
    authState.setUsername(username);
    authState.setPassword(password);

    // Call the login method from AuthState
    authState.login();

    //go to homepage
    if(authState.isLoggedIn){
    Navigator.pushReplacement(
            context, MaterialPageRoute(
          builder: (context) => const Homescreen()));
  }else{
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid username or password'))
    );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              const Icon(
                Icons.lock_open_outlined,
                size: 80,
              ),
              const SizedBox(height: 10),

              // Text
              const Text(
                "Calorie App",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Username textfield
              MyTextfield(
                obsecureText: false,
                hintText: "Username",
                textEditingController: usernameController,
              ),
              const SizedBox(height: 10),

              // Password textfield
              MyTextfield(
                hintText: "Password",
                obsecureText: true,
                textEditingController: passwordController,
                
              ),
              const SizedBox(height: 25),

              // Sign in button
              MyButton(
                onTap: login,
                text: 'Sign In',
              ),
              const SizedBox(height: 25),

              // Not a member? Register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a member?'),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.onTap,
                      // Navigate to the registration screen
                     
                    
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
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
