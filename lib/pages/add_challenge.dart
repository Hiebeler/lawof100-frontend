import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../components/error_dialog.dart';

class AddChallenge extends StatefulWidget {
  const AddChallenge({Key? key}) : super(key: key);

  @override
  State<AddChallenge> createState() => _AddChallengeState();
}

class _AddChallengeState extends State<AddChallenge> {
  String name = "";
  bool isPublic = true;
  DateTime selectedDate = DateTime.now();
  File? image;
  static const storage = FlutterSecureStorage();

  void getImage() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 1000, maxWidth: 1000);
      if (image == null) return;

      final File? imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("failed to pick image $e");
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(3000),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme:
                  ColorScheme.dark(primary: Theme.of(context).primaryColor),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<bool> saveToDb() async {
    String? token = await storage.read(key: "jwt");
    var private = !isPublic;
    var response = await http.post(
        Uri.parse("http://192.168.1.20:3000/challenge/createChallenge"),
        body: {
          "name": name,
          "private": private.toString(),
          "startDate": selectedDate.toString()
        },
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "x-auth-token": token.toString(),
        });
    String source = utf8.decode(response.bodyBytes);
    var responseData = json.decode(source);
    if (responseData["status"] == 1) {
      return true;
    }
    ErrorDialog("Ooops", responseData["message"]).showAlertDialog(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Add Challenge"),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: CircleAvatar(
                backgroundColor: Color.fromRGBO(20, 40, 30, 1),
                radius: 40,
                backgroundImage: image != null ? FileImage(image!) : null,
              ),
              onTap: getImage,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (text) {
                name = text;
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                hintText: "Challenge Name",
              ),
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
                      value: isPublic,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool? value) {
                        setState(() {
                          isPublic = value!;
                        });
                      }),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text("Public"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text("pick date"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () => saveToDb().then((value) => {
                      if (value) {Navigator.pop(context)}
                    }),
                child: const Text("Save"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
