import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/common/navigation/navigation.dart';
import 'package:weather_app/common/services/network_services.dart';
import 'package:weather_app/model/google_places_model/google_place.dart';
import 'package:weather_app/pages/home_page/home_view_model.dart';

class SearchCityViewModel extends BaseViewModel {

	BehaviorSubject<List<GooglePlace>> googlePlacesStream = BehaviorSubject<List<GooglePlace>>();

	StreamSink<List<GooglePlace>> get googlePlacesStreamIn => googlePlacesStream.sink;

	Stream<List<GooglePlace>> get googlePlacesStreamOut => googlePlacesStream.stream.asBroadcastStream();

	SearchCityViewModel();

	fetchPlaces(String query) {
		NetworkService.getPlaceWithAddress(query).then((placesResult) {
			googlePlacesStreamIn.add(placesResult);
			print(placesResult);
		});
	}

	goToCityWeatherDetail(GooglePlace selectedCity) {
		Navigation.pushReplacement(AppPage.home, viewModel: HomeViewModel(selectedCity));
	}

	@override
  void dispose() {
    googlePlacesStream.close();
    super.dispose();
  }

}