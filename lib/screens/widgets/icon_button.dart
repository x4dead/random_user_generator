import 'package:flutter/material.dart';
import 'package:random_user_generator/theme/Color/colors.dart';

class IconButtonBorder extends StatelessWidget {
  const IconButtonBorder(
      {Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  final Icon icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: UserColor.colorTransparent,
            elevation: 0,
            side: const BorderSide(color: UserColor.colorFF757575)),
        onPressed: onPressed,
        child: icon,
      ),
    );
  }
}
