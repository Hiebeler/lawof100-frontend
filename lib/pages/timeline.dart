import 'package:flutter/material.dart';
import 'package:lawof100/components/log_timeline.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: Text(
                  "Timeline",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            const LogTimeline(),
            const LogTimeline(),
            const LogTimeline(),
            const LogTimeline(),
            const LogTimeline(),
            const LogTimeline(),
            const LogTimeline(),
            const LogTimeline(),
          ],
        ),
      ),
    );
  }
}
