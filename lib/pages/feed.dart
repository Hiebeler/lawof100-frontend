import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../components/grid.dart';
import '../components/log.dart';

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
        Uri.parse("http://192.168.1.20:3000/challenge/getAllChallenges"),
        headers: {
          "x-auth-token": token.toString(),
        });
    String source = utf8.decode(response.bodyBytes);
    var responseData = json.decode(source);
    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () =>
                      {Navigator.pushNamed(context, "/addChallenge")},
                  child: const Text("add Challenge"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                ),
              ),
              //Grids
              FutureBuilder(
                future: getChallengeData(),
                builder: (builder, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    List data = snapshot.data as List;
                    return Column(
                      children: [
                        ...(data).map((challenge) {
                          return Column(
                            children: [
                              Center(
                                child: Text(
                                  challenge["name"],
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Grid(gridList: const [1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,]),
                              ),

                              //Logs:
                              Log(text: "hallo", day: "2", done: true),
                              Log(text: "asdfasdf", day: "2", done: false),
                              Log(text: "hallo", day: "23", done: true),
                              Log(text: "hallo", day: "2", done: true),
                            ],
                          );
                        })
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
