import 'package:flutter/material.dart';
import 'package:flutter_airplane_passenger_convenience/views/login_signup_page.dart';
import 'package:flutter_airplane_passenger_convenience/views/seat_map.dart';

class HomeScreen extends StatefulWidget {
  final bool isLoggedIn;
  final String username;
  const HomeScreen(this.isLoggedIn, this.username, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Flights"),
        centerTitle: true,
      ),
       drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Welcome ${widget.username}"),
              accountEmail: const Text(""),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.flight),
              title: const Text("Your past flights"),
              selected: selectedIndex == 1,
              onTap: () {
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   builder: (_) => const LoginSignUp(),
                // ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              selected: selectedIndex == 2,
              onTap: () {
                // SessionManager.clearSession();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const LoginSignUp(),
                ));
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => SeatMap("abc"),
              ));
            },
            child: const Card(
              color: Colors.blue,
              elevation: 4,
              child: SizedBox(
                height: 300,
                child: ListTile(
                  title: Text('Flight #abc'),
                  subtitle: Text('Click to view more'),
                )
              ),
            )
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => SeatMap("def"),
              ));
            },
            child: const Card(
              color: Colors.blue,
              elevation: 4,
              child: SizedBox(
                height: 300,
                child: ListTile(
                  title: Text('Flight #def'),
                  subtitle: Text('Click to view more'),
                  
                )
              ),
            )
          ),
        ]
      ),
    );
  }
}