// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_airplane_passenger_convenience/models/user_data_model.dart';
import 'package:flutter_airplane_passenger_convenience/views/homescreen.dart';


class LoginSignUp extends StatefulWidget {
  const LoginSignUp({super.key});

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? selectedAirline;
  List<String> airlines = ['SouthWest Airlines', 'Delta Air Lines', 'United Airlines'];

  bool isRegistering = false;

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 50,),
                  const Text("Welcome,", style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 6,),
                  Text(isRegistering ? "Sign up to continue!" : "Sign in to continue!", style: TextStyle(fontSize: 20,color: Colors.grey.shade400),),
                ],
              ),
              Column(
                children: <Widget>[
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        )
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16,),
                  if(isRegistering) 
                    DropdownButtonFormField<String>(
                      value: selectedAirline,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedAirline = newValue;
                        });
                      },
                      items: airlines.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: "Select Airline",
                        labelStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  // const SizedBox(height: 12,),
                  // const Align(
                  //   alignment: Alignment.topRight,
                  //   child: Text("Forgot Password ?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                  // ),
                  const SizedBox(height: 30,),
                  if(!isRegistering)
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () => _login(context),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xffff5f6d),
                                Color(0xffff5f6d),
                                Color(0xffffc371),
                              ],
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(maxWidth: double.infinity, minHeight: 50),
                            child: const Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ),
                    if(isRegistering)
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () => _register(context),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xffff5f6d),
                                Color(0xffff5f6d),
                                Color(0xffffc371),
                              ],
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(maxWidth: double.infinity, minHeight: 50),
                            child: const Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16,),
                  const SizedBox(height: 30,),
                ],
              ),
              TextButton(
                onPressed: () => _toggleRegisterState(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text((isRegistering ? 'Cancel' : 'New User? Sign up'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red))],
                ),
              )
                  ],
          ),
        ),
      ),
    );
  }

  void _toggleRegisterState() {
    setState(() {
      isRegistering = !isRegistering;
    });
  }

    Future<void> _login(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    bool isLoggedIn = await UserDataModel().checkUserLoggedIn(username, password);

    if (!mounted) return;

    if (isLoggedIn) {

      if (!mounted) return;

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => HomeScreen(isLoggedIn, username),
      ));
    } else {
      showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('User might not be registered or the username and password may be incorrect. Try Again!'),
            ],
          ),
        ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),  
            ),
          ],
        );
      },
    );
    }
  }

  bool _validateEmail(String email) {
    bool isValid = true;
    if(email == null || email.isEmpty || !email.contains('@') || !email.contains('.') || !email.contains('.co')) {
      isValid = false;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Invalid email'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    return isValid;
  }

  bool validateAirlines(String? airlineName) {
    bool isValid = true;
    if(airlineName == null || airlineName == '') {
      isValid = false;
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Select an Airline'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    return isValid;
  }

  Future<void> _register(BuildContext context) async {
    final email = emailController.text;
    final username = usernameController.text;
    final password = passwordController.text;
    final user = UserDataModel();
    final enteredPassword = password;

    user.hashPassword(enteredPassword);

    bool emailValidation = _validateEmail(email);
    bool dropdownValidation = validateAirlines(selectedAirline);

    if(!emailValidation || !dropdownValidation) {
      return;
    }

    final newUser = UserDataModel(
      username: username,
      airline: selectedAirline,
      email: email,
      isLoggedIn: true
    );

    await newUser.dbSave();

    if (!mounted) return;

    if (newUser.isLoggedIn == true) {

      if (!mounted) return;

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => HomeScreen(true, username),
      ));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('User already registered'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}