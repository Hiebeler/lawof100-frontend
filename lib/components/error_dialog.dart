import 'package:flutter/material.dart';

class ErrorDialog {
  String title;
  String content;

  ErrorDialog(this.title, this.content, {Key? key});

  showAlertDialog(BuildContext context) {
    Widget okButton = ElevatedButton(
        onPressed: () => {Navigator.of(context).pop()},
        child: const Text("Ok"),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              Theme.of(context).primaryColor),
        ),
    );

    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      backgroundColor: Theme.of(context).backgroundColor,
      title: Text(title),
      content: Text(content, style: Theme.of(context).textTheme.bodyText2,),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
