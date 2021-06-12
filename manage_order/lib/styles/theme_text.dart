part of 'theme.dart';

class AppTextTheme {
  static const String titleFont = 'Comfortaa';
  static const String bodyFont = 'Noto Sans';
  static TextTheme get getTextTheme => const TextTheme(
        headline1: TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.normal,
          // fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.normal,
          // fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        bodyText2: TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        subtitle1: TextStyle(
          fontSize: 14,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        subtitle2: TextStyle(
          fontSize: 14,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      );

  static TextTheme get getActionTextTheme => const TextTheme(
        headline1: TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          color: AppThemeColor.color9D9D9D,
        ),
        headline2: TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          color: AppThemeColor.accent,
        ),
        headline3: TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          color: AppThemeColor.accent,
        ),
      );

  static TextTheme get getLogoTextTheme => const TextTheme(
        bodyText2: TextStyle(
          fontSize: 24,
          color: Colors.blue,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        bodyText1: TextStyle(
          fontSize: 50,
          color: AppThemeColor.primary,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
        ),
      );
}
