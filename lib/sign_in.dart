import 'package:flutter/material.dart';

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

  bool _isHidden = true;

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
                  onPressed: () => Navigator.pop(context),
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
