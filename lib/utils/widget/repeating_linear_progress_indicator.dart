import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:flutter/material.dart';

class RepeatingLinearProgressIndicator extends StatefulWidget {
  const RepeatingLinearProgressIndicator({super.key});

  @override
  RepeatingLinearProgressIndicatorState createState() =>
      RepeatingLinearProgressIndicatorState();
}

class RepeatingLinearProgressIndicatorState
    extends State<RepeatingLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Adjust the duration as needed.
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return LinearProgressIndicator(
          value: _animation.value,
          minHeight: 8.0,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation(AppColors.color153B0E),
         // borderRadius: BorderRadius.circular(15),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
