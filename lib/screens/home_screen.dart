import 'package:flutter/material.dart';
import 'package:myloginapp/screens/login_screen.dart';
import 'package:myloginapp/services/authe_service.dart';

AutheService _autheService = AutheService();
class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Screen'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Welcome To Admin Page"),
            ElevatedButton(onPressed:() {
              _autheService.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
            }, child: Text('SignOut'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },
      child: Icon(Icons.add),),
    );
  }
}

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Text("UserScreen")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },
      child: Icon(Icons.add),),
    );
  }
}