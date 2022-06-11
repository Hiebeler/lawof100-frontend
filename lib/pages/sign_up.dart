import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lawof100/components/dialog.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Color inputBackgroundColor = const Color.fromRGBO(36, 36, 36, 1.0);

  Color textColor = const Color.fromRGBO(234, 234, 234, 1.0);

  TextStyle hintTextStyle =
      const TextStyle(color: Color.fromRGBO(117, 117, 117, 1.0), fontSize: 15);

  bool _isHidden = true;
  bool _isHiddenrepetition = true;
  String email = "";
  String username = "";
  String password1 = "";
  String password2 = "";

  Future<int> registerUser() async {
    var response = await http.post(
        Uri.parse(dotenv.get("API_ADDRESS") + "/registration/register"),
        body: {
          "email": email,
          "username": username,
          "password1": password1,
          "password2": password2
        },
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        });

    String source = utf8.decode(response.bodyBytes);
    var responseData = json.decode(source);
    if (responseData["header"] == "Error") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog("Ooops", responseData["message"]);
          }
      );
    }
    return responseData["status"];
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
                  "Sign Up",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                onChanged: (text) {
                  email = text;
                },
                style: hintTextStyle.copyWith(color: textColor),
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
                  hintText: "Email",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                onChanged: (text) {
                  username = text;
                },
                style: hintTextStyle.copyWith(color: textColor),
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
                  hintText: "Username",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                onChanged: (text) {
                  password1 = text;
                },
                style: hintTextStyle.copyWith(color: textColor),
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
                  hintText: "Password",
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _isHidden = !_isHidden;
                      });
                    },
                    child: Icon(
                      _isHidden ? Icons.visibility : Icons.visibility_off,
                      color: textColor,
                    ),
                  ),
                ),
                obscureText: _isHidden,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                onChanged: (text) {
                  password2 = text;
                },
                style: hintTextStyle.copyWith(color: textColor),
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
                  hintText: "Repeat your password",
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _isHiddenrepetition = !_isHiddenrepetition;
                      });
                    },
                    child: Icon(
                      _isHiddenrepetition
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: textColor,
                    ),
                  ),
                ),
                obscureText: _isHiddenrepetition,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () => registerUser().then((value) {
                    if (value == 1) {
                      Navigator.pushNamed(context, "/verify");
                    }
                  }),
                  child: const Text("Register"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, "/signIn"),
                  child: const Text("login"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).backgroundColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
