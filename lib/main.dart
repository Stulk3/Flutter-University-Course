import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/about_screen.dart';
import 'ui/screens/settings_screen.dart';
import 'ui/screens/favorites_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "/Users/ivanaminov/Yandex.Disk.localized/Dev/GitHub/Flutter-University-Course/assets/.env");
  String? apiKey = dotenv.env['NEWS_API_KEY'];
  runApp(MyApp(apiKey: apiKey));
}


class MyApp extends StatefulWidget {
  final String? apiKey;
  const MyApp({super.key, this.apiKey});

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLocale(newLocale);
  }

  static void setTheme(BuildContext context, ThemeMode newThemeMode) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeTheme(newThemeMode);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        cardTheme: const CardThemeData(elevation: 4, margin: EdgeInsets.all(8)),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        cardTheme: const CardThemeData(elevation: 4, margin: EdgeInsets.all(8)),
      ),
      themeMode: _themeMode,
      locale: _locale,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: HomeScreen(apiKey: widget.apiKey),
      routes: {
        '/about': (context) => const AboutScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/favorites': (context) => const FavoritesScreen(),
      },
    );
  }
}