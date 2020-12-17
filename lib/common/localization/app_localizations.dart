import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/common/localization/app_localizations_delegate.dart';



class AppLocalizations {
	static const _replaceChar = '@!';
	final Locale locale;

	AppLocalizations(this.locale);


	// Helper method to keep the code in the widgets concise
	// Localizations are accessed using an InheritedWidget "of" syntax
	static AppLocalizations of(BuildContext context) {
		return Localizations.of<AppLocalizations>(context, AppLocalizations);
	}

	// Static member to have a simple access to the delegate from the MaterialApp
	static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();

	Map<String, String> _localizedStrings;

	Future<bool> load() async {
		// Load the language JSON file from the "lang" folder
		String jsonString = await rootBundle.loadString('localizations/${locale.languageCode}.json');
		Map<String, dynamic> jsonMap = json.decode(jsonString);

		_localizedStrings = jsonMap.map((key, value) {
			return MapEntry(key, value.toString());
		});

		return true;
	}

	// This method will be called from every widget which needs a localized text
	String translate(String key, {List<String> parameters, String errorMessageFromBackEnd}) {
		var s = _localizedStrings[key];

		if(s != null) {
			if (parameters != null && parameters.isNotEmpty) {
				parameters.forEach((p) => s = s.replaceFirst(_replaceChar, p));
			}
			return s;
		} else {
			if(errorMessageFromBackEnd != null) {
				return errorMessageFromBackEnd;
			} else {
				return _localizedStrings["generic_error"];
			}
		}
	}

	//String areYouAlreadyAtTheOffice(String office) => translate('are_you_already_at_the_office', parameters: [office]);
	String get appName => translate("app_name");
	String get cityPageTitle => translate("city_page_title");
	String get cityPageSearchPlaceholder => translate("city_page_search_placeholder");
	String get cityPageSearchNoResult => translate("city_page_search_no_result");
	String get today => translate("today");
	String get nextDays => translate("next_days");

}
