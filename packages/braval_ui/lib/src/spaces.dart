import 'package:flutter/widgets.dart';

/// Defines the spaces for the Braval UI
abstract class BravalSpaces {
  /// Horizontal
  static const double horizontal = 16;

  /// Vertical
  static const double vertical = 38;

  /// Between elements
  static const double betweenElements = 16;

  /// Separator Between Elements
  static const SizedBox elementsSeparator = SizedBox(
    height: betweenElements,
    width: betweenElements,
  );

  /// Separator Between Elements
  static const SizedBox mediumSeparator = SizedBox(
    height: 32,
    width: 32,
  );

  /// Big Separator Between Elements
  static const SizedBox bigSeparator = SizedBox(
    height: 40,
    width: 40,
  );
}
