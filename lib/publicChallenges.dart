import 'package:flutter/material.dart';

class PublicChallenges extends StatefulWidget {
  const PublicChallenges({Key? key}) : super(key: key);

  @override
  State<PublicChallenges> createState() => _PublicChallengesState();
}

class _PublicChallengesState extends State<PublicChallenges> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Public Challenges"),
    );
  }
}
