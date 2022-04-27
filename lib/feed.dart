import 'package:flutter/material.dart';
import 'package:lawof100/components/grid.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 60),
              child: Center(
                child: Text("challenge 1", style: Theme.of(context).textTheme.headline1,),
              ),),
          Padding(padding: EdgeInsets.only(top:20), child: Grid(gridList: const [1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,]),)

        ],
      ),
    ),);
  }
}
