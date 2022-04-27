import 'package:flutter/material.dart';
import 'package:lawof100/feed.dart';
import 'package:lawof100/profile.dart';
import 'package:lawof100/publicChallenges.dart';
import 'package:lawof100/timeline.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int navigationBarIndex = 0;
  var sites = [Feed(), Timeline(), PublicChallenges(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sites[navigationBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationBarIndex,
        onTap: (int index) {
          setState(() {
            navigationBarIndex = index;
          }
          );
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Timeline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Challenges',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}