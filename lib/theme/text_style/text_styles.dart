import 'package:flutter/cupertino.dart';

import '../Color/colors.dart';

abstract class UserTextStyle {
  static const TextStyle w500s24 = TextStyle(
    fontSize: 24,
    color: UserColor.colorFFFFFF,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle wBolds16 = TextStyle(
    fontSize: 16,
    color: UserColor.colorFFFFFF,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle w400s15_3 = TextStyle(
    fontSize: 15.3,
    color: UserColor.colorFFFFFF,
  );
}
