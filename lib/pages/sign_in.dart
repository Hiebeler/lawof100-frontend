import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lawof100/components/dialog.dart';


class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Color inputBackgroundColor = const Color.fromRGBO(36, 36, 36, 1.0);

  Color textColor = const Color.fromRGBO(234, 234, 234, 1.0);

  TextStyle hintTextStyle =
      const TextStyle(color: Color.fromRGBO(117, 117, 117, 1.0), fontSize: 15);

  final _storage = const FlutterSecureStorage();

  bool _isHidden = true;
  String email = "";
  String password = "";

  Future<bool> login() async {
    var response = await http.post(
        Uri.parse(dotenv.get("API_ADDRESS") + "/registration/login"),
        body: {
          "email": email,
          "password": password,
        },
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        });

    String source = utf8.decode(response.bodyBytes);
    var responseData = json.decode(source);
    if (responseData["token"] != null) {
      await _storage.delete(key: 'jwt');
      await _storage.write(key: 'jwt', value: responseData["token"]);
      return true;
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog("Ooops", responseData["message"]);
          }
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.headline1,
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
                  password = text;
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
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () => login().then((value) {
                    if (value) {
                      Navigator.pushNamed(context, "/home");
                    }
                  }),
                  child: const Text("Sign in"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, "/signUp"),
                  child: const Text("register"),
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
