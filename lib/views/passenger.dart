import 'package:flutter/material.dart';
import 'package:flutter_airplane_passenger_convenience/views/homescreen.dart';
import 'package:flutter_airplane_passenger_convenience/views/login_signup_page.dart';

bool isLoggedIn = false;
String loggedInUsername = '';
String loggedInName = '';

class Passenger extends StatefulWidget {
  const Passenger({super.key});

  @override
  State<Passenger> createState() => _PassengerState();
}

class _PassengerState extends State<Passenger> {
    @override
  void initState() {
    super.initState();
    _checkLoginStatusAndGetUsername();
  }

  Future<void> _checkLoginStatusAndGetUsername() async {
     if (mounted) {
      setState(() {
        isLoggedIn = false;
        loggedInName= loggedInUsername;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: isLoggedIn ? HomeScreen(isLoggedIn, loggedInName) : const LoginSignUp(),
    );
  }
}