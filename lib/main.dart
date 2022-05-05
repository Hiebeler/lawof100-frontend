import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lawof100/add_challenge.dart';
import 'package:lawof100/home.dart';
import 'package:lawof100/sign_in.dart';
import 'package:lawof100/sign_up.dart';
import 'package:lawof100/verify.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(Main());
  });
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  Future<String?> getJWT() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "jwt");
    if (token == null) {
      return "";
    }
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getJWT(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return MaterialApp(
          initialRoute: snapshot.data == "" ? '/signUp': '/home',
          routes: {
            '/home': (context) => const Home(),
            '/addChallenge': (context) => const AddChallenge(),
            '/signUp': (context) => SignUp(),
            '/signIn': (context) => SignIn(),
            '/verify': (context) => const Verify(),
          },
          theme: ThemeData(
            // Define the default brightness and colors.
            primaryColor: const Color.fromRGBO(8, 181, 102, 1.0),
            backgroundColor: const Color.fromRGBO(42, 46, 55, 1.0),

            colorScheme:
            ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
              secondary: const Color.fromRGBO(8, 181, 102, 1.0),
            ),

            // Define the default font family.
            fontFamily: 'Arial',

            // Define the default TextTheme. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              headline3: TextStyle(fontSize: 21.0),
              headline6: TextStyle(
                fontSize: 23.0,
              ),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
