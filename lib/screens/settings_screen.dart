import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:news_app/main.dart'; // Import the file where MyApp is defined

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.settingsTitle)),
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
          const Divider(),
          ListTile(
            title: Text(localizations.aboutScreenTitle),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
    );
  }

  void _changeLocale(BuildContext context, Locale locale) {
    MyApp.setLocale(context, locale); // Обновляем локаль приложения
    Navigator.pop(context); // Возвращаемся на предыдущий экран
  }
}