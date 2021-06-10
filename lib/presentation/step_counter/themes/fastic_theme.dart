import 'package:flutter/material.dart';

/// I used the light theme to set the Font Family
///
/// In a bigger application I would take my time to properly set a Theme so
/// it's congruent all around.
ThemeData fasticTheme = ThemeData.light().copyWith(
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'Lato',
      ),
  primaryTextTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'Lato',
      ),
  accentTextTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'Lato',
      ),
);
