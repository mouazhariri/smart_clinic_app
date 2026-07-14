import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class TypingDots extends StatefulWidget {
  const TypingDots({super.key});

  @override
  State<TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<TypingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dot(double start, double end) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final value =
            Curves.easeInOut.transform(
              ((_controller.value - start) / (end - start))
                  .clamp(0.0, 1.0),
            );

        return Opacity(
          opacity: value,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: CircleAvatar(
              radius: 3,
              backgroundColor: Colors.black54,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _dot(0.0, 0.4),
          _dot(0.2, 0.6),
          _dot(0.4, 0.8),
        ],
      ),
    );
  }
}