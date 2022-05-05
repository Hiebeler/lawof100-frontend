import 'package:flutter/material.dart';
import 'package:lawof100/pages/feed.dart';
import 'package:lawof100/pages/profile.dart';
import 'package:lawof100/pages/publicChallenges.dart';
import 'package:lawof100/pages/timeline.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int navigationBarIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => navigationBarIndex = index);
        },
        children: const [
          Feed(),
          Timeline(),
          PublicChallenges(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationBarIndex,
        onTap: (int index) {
          setState(() {
            navigationBarIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut);
          });
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
