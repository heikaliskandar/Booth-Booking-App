import 'package:flutter/material.dart';
import '../models/user.dart';
import 'booking.dart';
import 'account.dart';
import 'services.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({
    Key? key,
    required this.user,
    this.currentPage = 0,
  }) : super(key: key);

  final User user;
  final int currentPage;

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  final List<String> pageTitle = [
    "Services",
    "Booking",
    "Account",
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.currentPage;
    });
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      AreasPage(user: widget.user),
      ConferencePage(user: widget.user),
      AccountPage(user: widget.user),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          pageTitle[_selectedIndex],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search_off_rounded),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_rounded),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 24, 43, 92),
        onTap: _onItemTapped,
      ),
    );
  }
}
