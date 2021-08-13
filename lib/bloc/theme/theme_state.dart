part of 'theme_bloc.dart';

enum AppTheme { LightMode, DarkMode }

class ThemeState {
  final ThemeData themeData;
  final bool isDarkTheme;

  ThemeState({required this.themeData, required this.isDarkTheme});

  factory ThemeState.Initial() => ThemeState(
        themeData: ThemeData(
          brightness: Brightness.dark,
          primaryColor: HexColor.fromHex("#212121"),
          textSelectionTheme:
              TextSelectionThemeData(cursorColor: App.cursorColor),
        ),
        isDarkTheme: true,
      );

  factory ThemeState.DarkMode() => ThemeState(
        themeData: ThemeData(
          brightness: Brightness.dark,
          primaryColor: HexColor.fromHex("#212121"),
          textSelectionTheme:
              TextSelectionThemeData(cursorColor: App.cursorColor),
        ),
        isDarkTheme: true,
      );

  factory ThemeState.LightMode() => ThemeState(
        themeData: ThemeData(
          brightness: Brightness.light,
          primaryColor: HexColor.fromHex("#FAFAFA"),
        ),
        isDarkTheme: false,
      );
}
