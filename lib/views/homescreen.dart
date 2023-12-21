import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final bool isLoggedIn;
  final String username;
  const HomeScreen(this.isLoggedIn, this.username, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.username}"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {

        },
        child: const Card(
          child: ListTile(
            title: Text('Flight #abc'),
            subtitle: Text('Click to view more'),
          )
        )
      ),
    );
  }
}