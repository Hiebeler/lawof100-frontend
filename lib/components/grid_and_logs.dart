import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'grid.dart';
import 'log.dart';

class GridAndLogs extends StatefulWidget {
  final Map challenge;
  const GridAndLogs({required this.challenge});

  @override
  State<GridAndLogs> createState() => _GridAndLogsState();
}

class _GridAndLogsState extends State<GridAndLogs> {
  static const storage = FlutterSecureStorage();

  Future getEntries(int challengeId) async {
    String? token = await storage.read(key: "jwt");
    var response = await http.get(
        Uri.parse("http://" +
            dotenv.get("HOST") +
            ":" +
            dotenv.get("PORT") +
            "/challenge/getEntriesOfChallenge/" +
            challengeId.toString()),
        headers: {
          "x-auth-token": token.toString(),
        });
    String source = utf8.decode(response.bodyBytes);
    var responseData = json.decode(source);
    print(responseData);
    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getEntries(widget.challenge["id"]),
        builder: (builder, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List entries = snapshot.data as List;
            return Column(
              children: [
                Center(
                  child: Text(
                    widget.challenge["name"],
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Grid(
                    entriesList: entries,
                    startDateString: widget.challenge["startdate"],
                    challengeId: widget.challenge["id"],
                    reload: () {
                      setState(() {});
                    },
                  ),
                ),
                //Logs:
                ...(entries).map((e) {
                  return Log(
                      text: e["description"],
                      day: e["day"].toString(),
                      done: e["successful"]);
                })
              ],
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
