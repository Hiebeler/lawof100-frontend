import 'package:flutter/material.dart';
import 'package:lawof100/components/publicChallengeComponent.dart';

class PublicChallenges extends StatefulWidget {
  const PublicChallenges({Key? key}) : super(key: key);

  @override
  State<PublicChallenges> createState() => _PublicChallengesState();
}

class _PublicChallengesState extends State<PublicChallenges> {
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
                  "Public Challenges",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            const PublicChallengesComponent(),
            const PublicChallengesComponent(),
            const PublicChallengesComponent(),
          ],
        ),
      ),
    );
  }
}
