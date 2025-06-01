// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'News App';

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutName => 'Your Name';

  @override
  String get aboutGroup => 'Group: Your Group';

  @override
  String get aboutDescription => 'This is a news app developed for MIREA course.';

  @override
  String get noTitle => 'No Title';

  @override
  String get noDescription => 'No Description';

  @override
  String get noDate => 'No Date';

  @override
  String get errorLoading => 'Error loading articles';

  @override
  String get noArticles => 'No articles available';

  @override
  String get readMore => 'Read More';

  @override
  String get errorOpeningLink => 'Could not open the link';

  @override
  String get aboutScreenTitle => 'About Developers';

  @override
  String get settingsTitle => 'Settings';
}
