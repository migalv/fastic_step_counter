import 'dart:ui';

/// A class that contains all the colors of the app
///
/// This is perfect to locate all the colors in one place
class AppColors {
  static const orange = Color.fromRGBO(247, 165, 108, 1);
  static const fadeGray = Color.fromRGBO(237, 241, 243, 1);
  static const gray = Color.fromRGBO(166, 172, 180, 1);
  // Since I didn't find any colors for some parts of the app I reused the gray
  // color with a differente opacity
  static const gray30 = Color.fromRGBO(166, 172, 180, 0.3);
  static const gray20 = Color.fromRGBO(166, 172, 180, 0.2);
  static const softBlue = Color.fromRGBO(89, 98, 116, 1);
  static const darkBlue = Color.fromRGBO(31, 52, 85, 1);
}
