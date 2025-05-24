import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> get _localizedStrings => {
        'en': {
          'appTitle': 'News App',
          'aboutTitle': 'About',
          'aboutName': 'Your Name',
          'aboutGroup': 'Group: Your Group',
          'aboutDescription': 'This is a news app developed for MIREA course.',
          'noTitle': 'No Title',
          'noDescription': 'No Description',
          'noDate': 'No Date',
          'errorLoading': 'Error loading articles',
          'noArticles': 'No articles available',
          'readMore': 'Read More',
          'errorOpeningLink': 'Could not open the link',
        },
        'ru': {
          'appTitle': 'Новостное приложение',
          'aboutTitle': 'О приложении',
          'aboutName': 'Ваше Имя',
          'aboutGroup': 'Группа: Ваша Группа',
          'aboutDescription': 'Это новостное приложение, разработанное для курса МИРЭА.',
          'noTitle': 'Без заголовка',
          'noDescription': 'Без описания',
          'noDate': 'Без даты',
          'errorLoading': 'Ошибка загрузки статей',
          'noArticles': 'Статьи отсутствуют',
          'readMore': 'Читать далее',
          'errorOpeningLink': 'Не удалось открыть ссылку',
        },
      }[locale.languageCode] ?? {};

  String get appTitle => _localizedStrings['appTitle']!;
  String get aboutTitle => _localizedStrings['aboutTitle']!;
  String get aboutName => _localizedStrings['aboutName']!;
  String get aboutGroup => _localizedStrings['aboutGroup']!;
  String get aboutDescription => _localizedStrings['aboutDescription']!;
  String get noTitle => _localizedStrings['noTitle']!;
  String get noDescription => _localizedStrings['noDescription']!;
  String get noDate => _localizedStrings['noDate']!;
  String get errorLoading => _localizedStrings['errorLoading']!;
  String get noArticles => _localizedStrings['noArticles']!;
  String get readMore => _localizedStrings['readMore']!;
  String get errorOpeningLink => _localizedStrings['errorOpeningLink']!;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
