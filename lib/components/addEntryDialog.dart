import 'dart:convert';
import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddEntryDialog extends StatefulWidget {
  final int day;
  final int challengeId;
  const AddEntryDialog({required this.day, required this.challengeId});

  @override
  State<AddEntryDialog> createState() => _AddEntryDialogState();
}

class _AddEntryDialogState extends State<AddEntryDialog> {
  static const storage = FlutterSecureStorage();
  bool isSuccessful = true;
  String description = "";

  Future addEntry() async {
    print(widget.challengeId);
    String? token = await storage.read(key: "jwt");
    var response = await http.post(
        Uri.parse("http://" +
            dotenv.get("HOST") +
            ":" +
            dotenv.get("PORT") +
            "/challenge/addEntry/"),
        body: {
          "challengeId": widget.challengeId.toString(),
          "day": widget.day.toString(),
          "description": description,
          "successful": isSuccessful ? "1" : "0",
        },
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
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text('TextField in Dialog'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                description = value;
              },
              decoration: const InputDecoration(hintText: "description"),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                      value: isSuccessful,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool? value) {
                        setState(() {
                          isSuccessful = value!;
                        });
                      }),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text("Successful"),
              ],
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => {addEntry().then((value) {
              setState(() {
                Navigator.pop(context);
              });
            })},
            child: const Text("add"),
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
