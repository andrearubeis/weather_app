import 'package:stacked/stacked.dart';
import 'package:weather_app/common/navigation/navigation.dart';
import 'package:weather_app/pages/search_city_page/search_city_view_model.dart';

class CityViewModel extends BaseViewModel {

	CityViewModel();

	goToSearchCity() {
		Navigation.pushTo(AppPage.searchCity, SearchCityViewModel());
	}

}