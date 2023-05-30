import 'package:flutter/material.dart';
import 'package:cine_me/core/constants/colors.dart';

class ProgressPage extends StatelessWidget {
  final String processName;
  const ProgressPage({Key? key, required this.processName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              const CircularProgressIndicator(
                color: white,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                processName,
                style: const TextStyle(
                    fontWeight: FontWeight.w300, fontSize: 20, color: white),
              )
            ])));
  }
}
