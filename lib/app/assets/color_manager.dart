import 'package:flutter/material.dart';

class ColorManager {
  static const primaryColor = Color(0xFF1570EF);
  static const lightBlueColor = Color(0xFFEAFDFF);
  static const whiteColor = Color(0xFFFFFFFF);
}

class GradientColorManager {
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [
      ColorManager.lightBlueColor,
      ColorManager.primaryColor,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5],
  );
}

class StylesManager {
  static const selectedLabelStyle = TextStyle(fontSize: 10, color: ColorManager.lightBlueColor);
  static const unselectedLabelStyle = TextStyle(fontSize: 10, color: ColorManager.whiteColor);
}
