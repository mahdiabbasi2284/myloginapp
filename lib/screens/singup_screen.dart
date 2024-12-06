// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:myloginapp/screens/login_screen.dart';
import 'package:myloginapp/services/authe_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SingupScreen extends StatefulWidget {
  SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final AutheService _authService = AutheService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String selectedRole = "User"; //default selected role for dropdown
  bool _isLoading = false;
  bool isPasswordHidden = true;

  //instance for AuthService for authentication logic
  final AutheService _autheService = AutheService();
  //signup function to handle user registeration
  void _signup() async {
    setState(() {
      _isLoading = true;
    });

    String? result = await _autheService.signup(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        role: selectedRole);

    setState(() {
      _isLoading = false;
    });

    if (result == null) {
      // signup succcessful : Navigate to login screen with success message
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Signup Successful! Now Turn to Login'),
      ));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LoginScreen(),
          ));
    } else {
      //signup failde: show the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('signup Failed $result'),
        ),
      );
    }
  }

  void changeScreen() {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset('assets/3231416.jpg'),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  label: Text('Email'), border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                label: Text('Password'),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                  icon: isPasswordHidden
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ),
              obscureText: isPasswordHidden,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  label: Text('Name'), border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              value: selectedRole,
              decoration: const InputDecoration(
                labelText: "Role",
                border: OutlineInputBorder(),
              ),
              items: ["Admin", "User"].map((role) {
                return DropdownMenuItem(
                  child: Text(role),
                  value: role,
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedRole =
                      newValue!; // update roles selection in text feild
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _signup,
                      child: const Text('Sign up'),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 18),
                ),
                InkWell(
                  onTap: changeScreen,
                  child: Text(
                    "Login here",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade300,
                        letterSpacing: -1),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
