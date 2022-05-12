import 'package:flutter/material.dart';

class Log extends StatelessWidget {
  var text = "";
  var day = "";
  int done = 0;
  Log({Key? key, required this.text, required this.day, required this.done}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Day " + day),
                const SizedBox(width: 10,),
                done == 1 ? Icon(Icons.check, color: Theme.of(context).primaryColor,) : const Icon(Icons.close, color: Colors.red,)
              ],
            ),
            const SizedBox(height: 5,),
            Text(text, style: const TextStyle(fontSize: 20),)
          ],
        ));
  }
}
