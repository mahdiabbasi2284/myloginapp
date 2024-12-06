import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myloginapp/firebase_options.dart';
import 'package:myloginapp/screens/login_screen.dart';
import 'package:myloginapp/screens/singup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfire_cli/flutterfire_cli.dart';




void main() async {
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
    return MaterialApp(
      home: SingupScreen(),
    );
  }
}