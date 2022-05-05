import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lawof100/components/publicChallengeComponent.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  late TabController _tabController;
  static const storage = FlutterSecureStorage();

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

  Future<Map> getUser() async {
    String? token = await storage.read(key: "jwt");
    var response = await http.get(
        Uri.parse("http://10.110.48.135:3000/user/getuser"),
        headers: {"x-auth-token": token.toString()});

    String source = utf8.decode(response.bodyBytes);
    var responseData = json.decode(source);
    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map userData = snapshot.data as Map;
            return Padding(
              padding: const EdgeInsets.all(10),
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
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text(
                        "@" + userData["username"],
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
          } else {
            return Container();
          }
        });
  }
}
