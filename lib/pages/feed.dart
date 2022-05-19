import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lawof100/components/grid_and_logs.dart';


class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  static const storage = FlutterSecureStorage();

  Future getChallengeData() async {
    String? token = await storage.read(key: "jwt");
    var response = await http.get(
        Uri.parse("http://" +
            dotenv.get("HOST") +
            ":" +
            dotenv.get("PORT") +
            "/challenge/getAllAttendingChallenges"),
        headers: {
          "x-auth-token": token.toString(),
        });
    String source = utf8.decode(response.bodyBytes);
    var responseData = json.decode(source);
    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getChallengeData(),
        builder: (builder, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List challengeData = snapshot.data as List;
            return DefaultTabController(
              length: challengeData.length,
              child: Scaffold(
                appBar: AppBar(
                  title: Center(
                    child: PreferredSize(
                        child: TabBar(
                            indicatorColor: Theme.of(context).primaryColor,
                            labelColor: Colors.white,
                            isScrollable: true,
                            unselectedLabelColor: Colors.white.withOpacity(0.3),
                            tabs: [
                              ...(challengeData).map((challenge) {
                                return Tab(
                                  child: Text(challenge["name"]),
                                );
                              })
                            ]),
                        preferredSize: Size.fromHeight(30.0)),
                  ),
                ),
                body: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TabBarView(
                      children: [
                        ...(challengeData).map((challenge) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                           context, "/addChallenge");
                                      },
                                      child: const Text("add Challenge"),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context).primaryColor),
                                      ),
                                    ),
                                  ),
                                  GridAndLogs(challenge: challenge),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    )),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
