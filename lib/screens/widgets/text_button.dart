import 'package:flutter/material.dart';
import 'package:random_user_generator/theme/Color/colors.dart';
import 'package:random_user_generator/theme/text_style/text_styles.dart';

class TextButtonBorder extends StatelessWidget {
  const TextButtonBorder({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.isActive,
  }) : super(key: key);
  final Function() onPressed;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: isActive ? UserColor.color616161 : UserColor.color212121,
            elevation: 0,
            side: const BorderSide(color: UserColor.colorFF757575)),
        onPressed: onPressed,
        child: Text(
          title,
          style: UserTextStyle.w400s15_3,
        ),
      ),
    );
  }
}
