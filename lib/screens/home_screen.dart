import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSecond = twentyFiveMinutes;
  bool isRunning = false;
  late Timer timer;
  int pomodoros = 0;

  void onTick(Timer timer) {
    setState(() {
      totalSecond = totalSecond - 1;

      if (totalSecond == 0) {
        totalSecond = twentyFiveMinutes;
        isRunning = false;
        timer.cancel();
        pomodoros += 1;
      }
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );

    setState(() {
      isRunning = !isRunning;
    });
  }

  void onPausedPressed() {
    timer.cancel();
    setState(() {
      isRunning = !isRunning;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.')[0].substring(2, 7);
  }

  void onRestartPressed() {
    setState(() {
      totalSecond = twentyFiveMinutes;
      isRunning = false;
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSecond),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausedPressed : onStartPressed,
                    icon: isRunning
                        ? const Icon(Icons.pause_circle_outline_outlined)
                        : const Icon(Icons.play_circle_outline_outlined),
                  ),
                ),
                IconButton(
                  iconSize: 50,
                  color: Theme.of(context).cardColor,
                  onPressed: onRestartPressed,
                  icon: const Icon(Icons.restart_alt_outlined),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                          ),
                        ),
                        Text(
                          "$pomodoros",
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
