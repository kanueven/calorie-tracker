import 'package:calorie/auth/login_or_register.dart';
import 'package:calorie/data/objectbox.dart';
import 'package:calorie/provider/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



late ObjectBox objectBox;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create(); // Initialize ObjectBox
  runApp(ChangeNotifierProvider(create: (context) => AuthState(objectBox),
  child:const MyApp()
  ,)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginOrRegister(),
    );
  }
}
