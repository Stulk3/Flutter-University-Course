import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/settings_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? apiKey;
  await dotenv.load(fileName: "/Users/ivanaminov/Yandex.Disk.localized/Dev/GitHub/Flutter-University-Course/assets/.env");
  apiKey = dotenv.env['NEWS_API_KEY'];
  runApp(MyApp(apiKey: apiKey));
}

class MyApp extends StatefulWidget {
  final String? apiKey;
  const MyApp({super.key, this.apiKey});

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
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
      themeMode: ThemeMode.system,
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
      },
    );
  }
}