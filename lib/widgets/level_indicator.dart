import 'package:flutter/material.dart';
class LevelIndicator extends StatelessWidget {
  final double length;
  const LevelIndicator({Key? key,required this.length}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // tag: 'hero',
      child: LinearProgressIndicator(
          backgroundColor: const Color.fromRGBO(20, 20, 31, 0.1),
          value: length,
          valueColor: const AlwaysStoppedAnimation(Colors.green)),
    );
  }
}
