import 'package:flutter/material.dart';

class LogTimeline extends StatelessWidget {
  const LogTimeline({Key? key}) : super(key: key);

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
                  Text("bla bla bla", style: Theme.of(context).textTheme.headline3,),
                  Row(
                    children: [
                      Text("@hiebeler05", style: Theme.of(context).textTheme.bodyText2,),
                      Text(" | "),
                      Text("Day 1")
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text("challenge 1")
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
