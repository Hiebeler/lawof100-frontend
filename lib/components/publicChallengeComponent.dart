import 'package:flutter/material.dart';

class PublicChallengesComponent extends StatelessWidget {
  final name;
  final startDate;
  bool joined = true;

  Function? joinChallenge;

  PublicChallengesComponent.withoutJoinChallenge(
      {Key? key,
      required this.name,
      required this.startDate,
      required this.joined,
      required this.joinChallenge})
      : super(key: key);

  PublicChallengesComponent(
      {Key? key, required this.name, required this.startDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color.fromRGBO(20, 40, 30, 1),
                radius: 20,
                child: Text('A'),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "start Date: ",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    startDate.toString().substring(0, 10),
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  )
                                ],
                              ),
                              const Text("joined Users: 2011")
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: !joined
                          ? GestureDetector(
                              onTap: () {
                                joinChallenge!();
                              },
                              child: const Icon(Icons.add),
                            )
                          : const Icon(Icons.check),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
