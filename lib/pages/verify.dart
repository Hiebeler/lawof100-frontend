import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lawof100/components/error_dialog.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  Color inputBackgroundColor = const Color.fromRGBO(36, 36, 36, 1.0);

  Color textColor = const Color.fromRGBO(234, 234, 234, 1.0);

  TextStyle hintTextStyle =
      const TextStyle(color: Color.fromRGBO(117, 117, 117, 1.0), fontSize: 15);
  String code = "";

  Future<bool> verifyUser() async {
    var response = await http
        .get(Uri.parse("http://192.168.1.20:3000/registration/verify/" + code));

    String source = utf8.decode(response.bodyBytes);
    var responseData = json.decode(source);
    if (!responseData["verified"]) {
      ErrorDialog("Ooops", "wrong verification Code").showAlertDialog(context);
    }
    return responseData["verified"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Verify",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                onChanged: (text) {
                  code = text;
                },
                style: hintTextStyle.copyWith(color: textColor),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: inputBackgroundColor,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      )),
                  hintStyle: hintTextStyle,
                  hintText: "Code",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () => verifyUser().then((value) {
                    if (value) {
                      Navigator.pushNamed(context, "/signIn");
                    }
                  }),
                  child: const Text("Register"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
