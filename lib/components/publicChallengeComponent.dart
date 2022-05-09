import 'package:flutter/material.dart';

class PublicChallengesComponent extends StatelessWidget {
  final name;
  final startDate;
  const PublicChallengesComponent({required this.name, required this.startDate});

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
                  Text(name, style: Theme.of(context).textTheme.headline3,),
                  Row(
                    children: [
                      Text("start Date: ", style: Theme.of(context).textTheme.bodyText2,),
                      const SizedBox(height: 20,),
                      Text(startDate.toString().substring(0,10), style: Theme.of(context).textTheme.bodyText2,)
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
