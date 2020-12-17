import 'package:flutter/widgets.dart';
import 'package:weather_app/common/localization/app_localizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
	// This delegate instance will never change (it doesn't even have fields!)
	// It can provide a constant constructor.
	const AppLocalizationsDelegate();

	@override
	bool isSupported(Locale locale) {
		print(locale.languageCode);
		// Include all of your supported language codes here
		return ['en', 'it'].contains(locale.languageCode);
	}

	@override
	Future<AppLocalizations> load(Locale locale) async {
		// AppLocalizations class is where the JSON loading actually runs
		AppLocalizations localizations = new AppLocalizations(locale);
		await localizations.load();
		return localizations;
	}

	@override
	bool shouldReload(AppLocalizationsDelegate old) => false;

}