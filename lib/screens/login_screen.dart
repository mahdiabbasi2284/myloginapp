import 'package:flutter/material.dart';
import 'package:myloginapp/screens/home_screen.dart';
import 'package:myloginapp/screens/singup_screen.dart';
import 'package:myloginapp/services/authe_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AutheService _autheService = AutheService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordHiden = false;
  bool isLoading = false;

  void _login() async {
    setState(() {
      isLoading = true;
    });

    String? result = await _autheService.login(
        email: emailController.text, password: passwordController.text);

    setState(() {
      isLoading = false;
    });

    if (result == "Admin"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminScreen(),));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('login succeessful'))
      );
    }else if (result == "User"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserScreen(),));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('login succeessful'))
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('login faild $result'))
      );
    }
  }

  void changeScreen() {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingupScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              Image.asset("assets/3094350.jpg"),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordHiden = !isPasswordHiden;
                          });
                        },
                        icon: isPasswordHiden
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility))),
                obscureText: isPasswordHiden,
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: _login, 
                          child: const Text('Login')),
                    ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "dont have an account?",
                    style: TextStyle(fontSize: 18),
                  ),
                  InkWell(
                    onTap: changeScreen,
                    child: Text(
                      "sign up here",
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
      ),
    );
  }
}
