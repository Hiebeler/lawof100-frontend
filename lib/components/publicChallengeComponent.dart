import 'package:flutter/material.dart';
import 'package:lawof100/components/grid_and_logs.dart';

class PublicChallengesComponent extends StatelessWidget {
  final name;
  final startDate;
  bool joined = true;
  bool withJoined = false;
  Function? joinChallenge;
  bool isFinished = false;
  Map? challenge;

  PublicChallengesComponent.withJoinChallenge(
      {Key? key,
      required this.name,
      required this.startDate,
      required this.joined,
      required this.joinChallenge}) {
    withJoined = true;
  }

  PublicChallengesComponent(
      {Key? key,
      required this.name,
      required this.startDate,
      required this.isFinished,
      required this.challenge})
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
                    withJoined == true
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: !joined
                                ? GestureDetector(
                                    onTap: () {
                                      joinChallenge!();
                                    },
                                    child: const Icon(Icons.add),
                                  )
                                : const Icon(Icons.check),
                          )
                        : isFinished == true
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => GridAndLogs(
                                              challenge: challenge!)));
                                },
                                child: const Text("show Challenge"))
                            : Container(),
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
