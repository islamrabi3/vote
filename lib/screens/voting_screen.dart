import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter_polls/flutter_polls.dart';

import '../model/candidate.dart';

class VotingScreen extends StatefulWidget {
  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  bool hasVoted = false;

  Timer? _timer;
  int _remainingDays = 3;
  int _remainingHours = 0;
  int _remainingMinutes = 0;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    startCountdownTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startCountdownTimer() {
    const oneSecond = Duration(seconds: 1);
    final threeDaysFromNow = DateTime.now().add(Duration(days: _remainingDays));

    _timer = Timer.periodic(oneSecond, (timer) {
      final now = DateTime.now();
      final difference = threeDaysFromNow.difference(now);

      setState(() {
        _remainingDays = difference.inDays;
        _remainingHours = difference.inHours % 24;
        _remainingMinutes = difference.inMinutes % 60;
        _remainingSeconds = difference.inSeconds % 60;

        if (difference.isNegative) {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Time Remaining:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '$_remainingDays Days $_remainingHours Hours $_remainingMinutes Minutes $_remainingSeconds Seconds',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  FlutterPolls(
                    pollId: '1',
                    onVoted: (pollOption, newTotalVotes) async {
                      return pollOption.votes.isEven;
                    },
                    pollOptionsHeight: 50.0,
                    pollOptionsSplashColor: Colors.purple,
                    pollOptionsFillColor: Colors.purple,
                    voteInProgressColor: Colors.blue,
                    pollTitle: const Text(
                      'For you, Who is the ideal Employee in 2023 ? ',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    pollOptions: candiates
                        .map((e) => PollOption(
                            title: Text(
                              e.name!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            votes: e.votes!,
                            id: e.id))
                        .toList(),
                    hasVoted: hasVoted,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
