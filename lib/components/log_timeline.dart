import 'package:flutter/material.dart';

class LogTimeline extends StatelessWidget {
  Map entry;
  bool done = false;
  LogTimeline({required this.entry}) {
    done = entry["successful"] == 1 ? true : false;
  }

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
                                entry["description"],
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              Text(
                                entry["username"] +
                                    " | Day " +
                                    entry["day"].toString(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              const Text("joined Users: 2011")
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: !done
                          ? Icon(Icons.close, color: Colors.red)
                          : Icon(Icons.check, color: Theme.of(context).primaryColor,),
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
