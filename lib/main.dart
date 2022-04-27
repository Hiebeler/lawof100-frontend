import 'package:flutter/material.dart';
import 'package:lawof100/home.dart';
import 'package:lawof100/profile.dart';
import 'package:lawof100/timeline.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
      },
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(8, 181, 102, 1.0),
        backgroundColor: Color.fromRGBO(42, 46, 55, 1.0),


        // Define the default font family.
        fontFamily: 'Arial',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
    );
  }
}
