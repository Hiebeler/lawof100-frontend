import 'package:flutter/material.dart';

class Log extends StatelessWidget {
  var text = "";
  var day = "";
  var done = false;
  Log({required this.text, required this.day, required this.done});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Day " + day),
                SizedBox(width: 10,),
                done ? Icon(Icons.check, color: Theme.of(context).primaryColor,) : Icon(Icons.close, color: Colors.red,)
              ],
            ),
            const SizedBox(height: 5,),
            Text(text, style: TextStyle(fontSize: 20),)
          ],
        ));
  }
}
