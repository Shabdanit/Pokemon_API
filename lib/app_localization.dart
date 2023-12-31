// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';
//
// class AppLocalizations {
//   final Locale locale;
//
//   AppLocalizations(this.locale);
//
//   static AppLocalizations of(BuildContext context) {
//     return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
//   }
//
//   late Map<String, String> _localizedStrings;
//
//   Future<bool> load() async {
//     String jsonString = await rootBundle.loadString('lib/l10n/app_${locale.languageCode}_${locale.countryCode}.arb');
//     Map<String, dynamic> jsonMap = json.decode(jsonString);
//
//     _localizedStrings = jsonMap.map((key, value) {
//       return MapEntry(key, value.toString());
//     });
//
//     return true;
//   }
//
//   String translate(String key) {
//     return _localizedStrings[key] ?? key;
//   }
// }
//
// class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
//   const AppLocalizationsDelegate();
//
//   @override
//   bool isSupported(Locale locale) {
//     return ['en', 'ru'].contains(locale.languageCode);
//   }
//
//   @override
//   Future<AppLocalizations> load(Locale locale) async {
//     AppLocalizations localizations = AppLocalizations(locale);
//     await localizations.load();
//     return localizations;
//   }
//
//   @override
//   bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
//     return false;
//   }
// }
