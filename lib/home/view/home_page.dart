import 'package:flutter/material.dart';

import 'package:braval/home/home.dart';
import 'package:braval/calendar/calendar.dart';
import 'package:braval/profile/profile.dart';
import 'package:braval/team/team.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route<HomePage> route() =>
      MaterialPageRoute<HomePage>(builder: (_) => const HomePage());

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexPage,
        onTap: (index) {
          setState(() {
            indexPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: 'Equipo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
      body: IndexedStack(
        index: indexPage,
        children: const [
          HomeView(),
          CalendarPage(),
          TeamPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
