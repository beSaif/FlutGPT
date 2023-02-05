import 'dart:async';
import 'package:flutter/material.dart';

class BlinkingCursor extends StatefulWidget {
  const BlinkingCursor({super.key});

  @override
  State<BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<BlinkingCursor> {
  bool _showCursor = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // check if mounted
    if (mounted) {
      timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
        setState(() {
          _showCursor = !_showCursor;
        });
      });
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11,
      height: 22,
      color: _showCursor
          ? Theme.of(context).textTheme.bodyMedium!.color
          : Colors.transparent,
    );
  }
}
