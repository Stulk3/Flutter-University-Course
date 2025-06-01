// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Новостное приложение';

  @override
  String get aboutTitle => 'О приложении';

  @override
  String get aboutName => 'Ваше Имя';

  @override
  String get aboutGroup => 'Группа: Ваша Группа';

  @override
  String get aboutDescription => 'Это новостное приложение, разработанное для курса МИРЭА.';

  @override
  String get noTitle => 'Без заголовка';

  @override
  String get noDescription => 'Без описания';

  @override
  String get noDate => 'Без даты';

  @override
  String get errorLoading => 'Ошибка загрузки статей';

  @override
  String get noArticles => 'Статьи отсутствуют';

  @override
  String get readMore => 'Читать далее';

  @override
  String get errorOpeningLink => 'Не удалось открыть ссылку';

  @override
  String get aboutScreenTitle => 'О разработчиках';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get favoritesScreenTitle => 'Избранные статьи';
}
