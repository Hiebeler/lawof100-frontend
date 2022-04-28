import 'package:flutter/material.dart';
import 'package:lawof100/components/publicChallengeComponent.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: CircleAvatar(
                backgroundColor: Color.fromRGBO(20, 40, 30, 1),
                radius: 70,
                child: Text('A'),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Daniel Hiebeler',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                '@daniebeler',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Colors.white,
            tabs: const [Tab(text: "Attended"), Tab(text: 'Created')],
            controller: _tabController,
          ),
          Expanded(
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: const [
                      PublicChallengesComponent(),
                      PublicChallengesComponent(),
                      PublicChallengesComponent(),
                      PublicChallengesComponent(),
                      PublicChallengesComponent(),
                      PublicChallengesComponent(),
                      PublicChallengesComponent(),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: const [
                      PublicChallengesComponent(),
                      PublicChallengesComponent(),
                      PublicChallengesComponent(),
                      PublicChallengesComponent(),
                    ],
                  ),
                ),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}
