import 'package:flutter/material.dart';
import 'package:lawof100/my_globals.dart';

import 'addEntryDialog.dart';

class CustomDialog extends StatefulWidget {
  String title;
  String content;
  bool change = false;
  int day = 0;
  int challengeId = 0;
  Function reload = () => {};

  CustomDialog.entry(this.title, this.content, this.change, this.day,
      this.challengeId, this.reload,
      {Key? key})
      : super(key: key);

  CustomDialog(this.title, this.content, {Key? key}) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = ElevatedButton(
      onPressed: () => {Navigator.of(context).pop()},
      child: const Text("Ok"),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
      ),
    );

    Widget changeButton = ElevatedButton(
      onPressed: () => {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddEntryDialog(
                day: widget.day,
                challengeId: widget.challengeId,
                reload: () {
                  widget.reload();
                });
          },
        ).then((valueFromDialog) {
          setState(() {
            widget.content = valueFromDialog;
          });
        })
      },
      child: const Text("change"),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
      ),
    );

    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      backgroundColor: Theme.of(context).backgroundColor,
      title: Text(widget.title),
      content: Text(
        widget.content,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: [
        widget.change ? changeButton : Container(),
        okButton,
      ],
    );
  }
}