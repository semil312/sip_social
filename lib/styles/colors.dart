import 'package:flutter/material.dart';

class AppColors {
  /// Common

  final Color primaryPurpleColor = const Color(0xff7815CD);
  final Color primaryOrangeColor = const Color(0xffFF9534);
  final Color primaryTurquoiseColor = const Color(0xff3BB3BD);
  final Color secondaryVioletColor = const Color(0xffB730E1);
  final Color secondarySandColor = const Color(0xffDAB186);

  final Color accentColor = const Color(0xffF82B2B);
  final Color backgroundColor = const Color(0xFFF3F1ED);
  final Color profileBackgroundColor = const Color(0x508667F2);

  final Color greyColor = const Color(0xffF3F1ED);
  final Color blueColor = const Color(0xff007AFF);
  final Color dotColor = const Color(0xffE3E0D8);

  final Color onPrimary = const Color(0xffffffff);
  final Color onPrimaryContainer = const Color(0xff212121);

  final Color black = const Color(0xff212121);
  final Color white = Colors.white;

  final Color body = const Color(0xff666666);

  final Color greyStrong = const Color(0xFFEAEAEA);
  final Color greyMedium = const Color(0xFFEAEAEA);
  final Color greyLight = const Color(0xFFE6E6E8);

  final Color error = Colors.red.shade400;

  final Color accent2 = const Color(0xFFBEABA1);
  final Color offWhite = const Color(0xFFF8ECE5);
  final Color caption = const Color(0xFF7D7873);

  final bool isDark = false;
  //
  // Color shift(Color c, double d) =>
  //     ColorUtils.shiftHsl(c, d * (isDark ? -1 : 1));

  ColorScheme toColorScheme() {
    ColorScheme colorScheme = ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: primaryPurpleColor,
      onPrimary: onPrimary,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondaryVioletColor,
      onSecondary: onPrimary,
      secondaryContainer: secondarySandColor,
      onSecondaryContainer: onPrimaryContainer,
      background: white,
      surface: white,
      onBackground: black,
      onSurface: black,
      error: error,
      onError: Colors.white,
    );
    return colorScheme;
  }
}
