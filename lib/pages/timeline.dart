import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lawof100/components/log_timeline.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  static const storage = FlutterSecureStorage();

  Future getEntries() async {
    String? token = await storage.read(key: "jwt");
    var response = await http.get(
        Uri.parse("http://" +
            dotenv.get("HOST") +
            ":" +
            dotenv.get("PORT") +
            "/challenge/getAllEntries"),
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
      child: FutureBuilder(
        future: getEntries(),
        builder: (builder, snapshot) {
          if (snapshot.hasData) {
            List entries = snapshot.data as List;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Center(
                      child: Text(
                        "Timeline",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  ...entries.map((e) {
                    return LogTimeline(entry: e);
                  }),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
