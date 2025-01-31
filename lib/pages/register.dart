import 'package:calorie/components/my_button.dart';
import 'package:calorie/components/my_textfield.dart';
import 'package:calorie/pages/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_state.dart';

class RegisterPage extends StatefulWidget {
  final Function()?  onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
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
                "Create an account",
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

               // confirmPassword textfield
              MyTextfield(
                hintText: "ConfirmPassword",
                obsecureText: true,
                textEditingController: confirmPasswordController,
              ),
              const SizedBox(height: 25),

              // Sign in button
              MyButton(
                onTap: () {
                  //interact with authstate to actually register
                  final authState = Provider.of<AuthState>(context, listen: false);
                  //set user credentials
                  authState.setUsername(usernameController.text);
                  authState.setPassword(passwordController.text);
                  authState.setConfirmPassword(confirmPasswordController.text);
                  //call register function
                  authState.register();
                 
                   
                    // Navigate to HomeScreen on successful registration
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Homescreen()),
                    );
                
                },
                text: 'Sign Up',
              ),
              const SizedBox(height: 25),

              // Already have an account? Login now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.onTap,
                      // Navigate to the registration screen
                     
                    
                    child: const Text(
                      'Login now',
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
