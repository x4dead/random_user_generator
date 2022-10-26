import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:random_user_generator/theme/Color/colors.dart';

class DefaultButton extends StatefulWidget {
  const DefaultButton({
    Key? key,
    required this.onPressed,
    required this.isLoading,
  }) : super(key: key);

  final Function() onPressed;
  final bool isLoading;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton>
    with SingleTickerProviderStateMixin {
  @override
  void didUpdateWidget(covariant DefaultButton oldWidget) {
    if (widget.isLoading) {
      animatiobController.repeat();
    } else {
      animatiobController.stop();
    }
    super.didUpdateWidget(oldWidget);
  }

  late final animatiobController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(primary: UserColor.color4CAF50),
        child: RotationTransition(
          turns: animatiobController,
          child: const Icon(
            Icons.refresh,
            size: 45,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animatiobController.dispose();
    super.dispose();
  }
}
