import 'package:flutter/material.dart';

class LogTimeline extends StatelessWidget {
  Map entry;
  LogTimeline({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color.fromRGBO(20, 40, 30, 1),
                radius: 20,
                child: Text('A'),
              ),
              const SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry["description"], style: Theme.of(context).textTheme.headline3,),
                  Row(
                    children: [
                      Text(entry["username"].toString(), style: Theme.of(context).textTheme.bodyText2,),
                      const Text(" | "),
                      Text("Day " + entry["day"].toString())
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Text(entry["challenge_name"])
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
