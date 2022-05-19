import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lawof100/components/publicChallengeComponent.dart';

class PublicChallenges extends StatefulWidget {
  const PublicChallenges({Key? key}) : super(key: key);

  @override
  State<PublicChallenges> createState() => _PublicChallengesState();
}

class _PublicChallengesState extends State<PublicChallenges> {
  static const storage = FlutterSecureStorage();

  Future getAllChallenges() async {
    print("get All Challenges");
    String? token = await storage.read(key: "jwt");
    var response = await http.get(
        Uri.parse("http://" +
            dotenv.get("HOST") +
            ":" +
            dotenv.get("PORT") +
            "/challenge/getAllChallengesWithJoinedField"),
        headers: {
          "x-auth-token": token.toString(),
        });
    String source = utf8.decode(response.bodyBytes);
    var responseData = json.decode(source);
    return responseData;
  }

  Future<bool>? joinChallenge(int challengeId) async {
    String? token = await storage.read(key: "jwt");
    var response = await http.post(
        Uri.parse("http://" +
            dotenv.get("HOST") +
            ":" +
            dotenv.get("PORT") +
            "/challenge/joinChallenge"),
        body: {
          "challengeId": challengeId.toString(),
          "startDate": DateTime.now().toString(),
        },
        headers: {
          "x-auth-token": token.toString(),
        });
    String source = utf8.decode(response.bodyBytes);
    var responseData = json.decode(source);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: Text(
                  "Public Challenges",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            FutureBuilder(
              future: getAllChallenges(),
              builder: (builder, snapshot) {
                if (snapshot.hasData) {
                  List data = snapshot.data as List;
                  return Column(children: [
                    ...(data).map((challenge) {
                      return Align(
                          alignment: Alignment.centerLeft,
                          child: PublicChallengesComponent.withJoinChallenge(
                              name: challenge["name"],
                              startDate: challenge["startdate"],
                              joined: challenge["fk_user_id"] == null ? false : true,
                              joinChallenge: () =>
                                  joinChallenge(challenge["id"])?.then((value) {
                                    setState(() {});
                                  })));
                    })
                  ]);
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
