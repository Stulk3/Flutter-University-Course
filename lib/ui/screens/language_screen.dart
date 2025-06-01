import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../l10n/app_localizations.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.aboutTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Русский'),
            onTap: () {
              _changeLocale(context, const Locale('ru', 'RU'));
            },
          ),
          ListTile(
            title: const Text('English'),
            onTap: () {
              _changeLocale(context, const Locale('en', 'US'));
            },
          ),
        ],
      ),
    );
  }

  void _changeLocale(BuildContext context, Locale locale) {
    Locale? localeOverride = locale;
    Navigator.pushReplacementNamed(context, '/');
  }
}