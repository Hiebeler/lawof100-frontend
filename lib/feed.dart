import 'package:flutter/material.dart';
import 'package:lawof100/components/grid.dart';
import 'package:lawof100/components/log.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(onPressed: () => {Navigator.pushNamed(context, "/addChallenge")}, child: Text("add Challenge"), style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),),
              ),

              Center(
                child: Text(
                  "challenge 1",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Grid(gridList: const [1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,]),
              ),
              Log(text: "hallo", day: "2", done: true),
              Log(text: "asdfasdf", day: "2", done: false),
              Log(text: "hallo", day: "23", done: true),
              Log(text: "hallo", day: "2", done: true),
            ],
          ),
        ),
      ),
    );
  }
}
