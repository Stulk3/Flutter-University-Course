import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart'; // Import the file where MyApp is defined

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeMode _selectedThemeMode = ThemeMode.system;

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
          const Divider(),
          ListTile(
            title: const Text('Выбор темы'),
            subtitle: DropdownButton<ThemeMode>(
              value: _selectedThemeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Светлая тема'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Темная тема'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('Системная тема'),
                ),
              ],
              onChanged: (ThemeMode? newThemeMode) {
                if (newThemeMode != null) {
                  setState(() {
                    _selectedThemeMode = newThemeMode;
                  });
                  _changeTheme(context, newThemeMode);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _changeLocale(BuildContext context, Locale locale) {
    MyApp.setLocale(context, locale); // Обновляем локаль приложения
    Navigator.pop(context); // Возвращаемся на предыдущий экран
  }

  void _changeTheme(BuildContext context, ThemeMode themeMode) {
    MyApp.setTheme(context, themeMode); // Обновляем тему приложения
  }
}