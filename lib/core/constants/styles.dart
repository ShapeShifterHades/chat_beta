import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Styles - Contains the design system for the entire app.
///
/// Includes paddings, text styles, timings etc. Does not include colors,
/// check [AppTheme] file for that.

/// /// Used for all animations in the  app
class Times {
  static const Duration fastest = Duration(milliseconds: 150);
  static const fast = Duration(milliseconds: 250);
  static const medium = Duration(milliseconds: 350);
  static const slow = Duration(milliseconds: 700);
  static const slower = Duration(milliseconds: 1000);
}

// ignore: avoid_classes_with_only_static_members
class Insets {
  static double scale = 1;
  static double offsetScale = 1;
  // Regular paddings
  static double get xs => 4 * scale;
  static double get sm => 8 * scale;
  static double get med => 12 * scale;
  static double get lg => 16 * scale;
  static double get xl => 32 * scale;
  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

class IconSizes {
  static const double scale = 1;
  static const double med = 24;
}

class Corners {
  static const double sm = 3;
  static const BorderRadius smBorder = BorderRadius.all(smRadius);
  static const Radius smRadius = Radius.circular(sm);

  static const double med = 5;
  static const BorderRadius medBorder = BorderRadius.all(medRadius);
  static const Radius medRadius = Radius.circular(med);

  static const double lg = 8;
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static const Radius lgRadius = Radius.circular(lg);
}

class Strokes {
  static const double thin = 1;
  static const double thick = 4;
}

// ignore: avoid_classes_with_only_static_members
/// Font Sizes
/// You can use these directly if you need, but usually there should be a predefined style in TextStyles.
class FontSizes {
  /// Provides the ability to nudge the app-wide font scale in either direction
  static double get scale => 1;
  static double get s10 => 10 * scale;
  static double get s11 => 11 * scale;
  static double get s12 => 12 * scale;
  static double get s14 => 14 * scale;
  static double get s16 => 16 * scale;
  static double get s24 => 24 * scale;
  static double get s48 => 48 * scale;
}

/// Fonts - A list of Font Families, this is uses by the TextStyles class to create concrete styles.
class Fonts {
  static const String iceland = "Iceland";
  static const String jura = "Jura";
}

// ignore: avoid_classes_with_only_static_members
class TextStyles {
  /// Declare a base style for each Family
  static const TextStyle iceland = TextStyle(
      fontFamily: Fonts.iceland, fontWeight: FontWeight.w400, height: 1);
  static const TextStyle jura =
      TextStyle(fontFamily: Fonts.jura, fontWeight: FontWeight.w400, height: 1);

  static TextStyle get h1 => iceland.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: FontSizes.s48,
      letterSpacing: -1,
      height: 1.17);
  static TextStyle get h2 =>
      h1.copyWith(fontSize: FontSizes.s24, letterSpacing: -.5, height: 1.16);
  static TextStyle get h3 =>
      h1.copyWith(fontSize: FontSizes.s14, letterSpacing: -.05, height: 1.29);
  static TextStyle get title1 => jura.copyWith(
      fontWeight: FontWeight.bold, fontSize: FontSizes.s16, height: 1.31);
  static TextStyle get title2 => title1.copyWith(
      fontWeight: FontWeight.w500, fontSize: FontSizes.s14, height: 1.36);
  static TextStyle get body1 => jura.copyWith(
      fontWeight: FontWeight.normal, fontSize: FontSizes.s14, height: 1.71);
  static TextStyle get body2 =>
      body1.copyWith(fontSize: FontSizes.s12, height: 1.5, letterSpacing: .2);
  static TextStyle get body3 => body1.copyWith(
      fontSize: FontSizes.s12, height: 1.5, fontWeight: FontWeight.bold);
  static TextStyle get callout1 => jura.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: FontSizes.s12,
      height: 1.17,
      letterSpacing: .5);
  static TextStyle get callout2 =>
      callout1.copyWith(fontSize: FontSizes.s10, height: 1, letterSpacing: .25);
  static TextStyle get caption => jura.copyWith(
      fontWeight: FontWeight.w500, fontSize: FontSizes.s11, height: 1.36);
}
