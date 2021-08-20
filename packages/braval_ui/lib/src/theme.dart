import 'package:braval_ui/src/typography/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:braval_ui/braval_ui.dart';

/// Namespace for the Braval [ThemeData]
class BravalTheme {
  /// Standard `ThemeData` for Braval UI
  static ThemeData get standard {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(accentColor: BravalColors.oceanGreen),
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textTheme: _textTheme,
      dialogBackgroundColor: BravalColors.whiteBackground,
      dialogTheme: _dialogTheme,
      tooltipTheme: _tooltipTheme,
      tabBarTheme: _tabBarTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      dividerTheme: _dividerTheme,
      scaffoldBackgroundColor: BravalColors.tuna,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      headline1: BravalTextStyle.headline1,
      headline2: BravalTextStyle.headline2,
      headline3: BravalTextStyle.headline3,
      headline4: BravalTextStyle.headline4,
      headline5: BravalTextStyle.headline5,
      headline6: BravalTextStyle.headline6,
      subtitle1: BravalTextStyle.subtitle1,
      subtitle2: BravalTextStyle.subtitle2,
      bodyText1: BravalTextStyle.bodyText1,
      bodyText2: BravalTextStyle.bodyText2,
      caption: BravalTextStyle.caption,
      overline: BravalTextStyle.overline,
      button: BravalTextStyle.button,
    );
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(color: BravalColors.shark);
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: BravalTextStyle.button,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        primary: BravalColors.oceanGreen,
        // minimumSize: const Size(208, 54),
      ),
    );
  }

  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        side: const BorderSide(color: BravalColors.oceanGreen, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16),
        primary: BravalColors.oceanGreen,
        // minimumSize: const Size(208, 54),
      ),
    );
  }

  static TooltipThemeData get _tooltipTheme {
    return const TooltipThemeData(
      decoration: BoxDecoration(
        color: BravalColors.charcoal,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.all(10),
      textStyle: TextStyle(color: BravalColors.white),
    );
  }

  static DialogTheme get _dialogTheme {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static TabBarTheme get _tabBarTheme {
    return const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2, color: BravalColors.oceanGreen),
      ),
      labelColor: BravalColors.oceanGreen,
      unselectedLabelColor: BravalColors.white,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }

  static BottomNavigationBarThemeData get _bottomNavigationBarTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: BravalColors.shark,
      selectedItemColor: BravalColors.oceanGreen,
      unselectedItemColor: BravalColors.silver,
      selectedLabelStyle: BravalTextStyle.bodyText2.copyWith(
        color: BravalColors.oceanGreen,
      ),
      unselectedLabelStyle: BravalTextStyle.bodyText2.copyWith(
        color: BravalColors.silver,
      ),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }

  static DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      space: 0,
      thickness: 1,
      color: BravalColors.silver,
    );
  }
}
