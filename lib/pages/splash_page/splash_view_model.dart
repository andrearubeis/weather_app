import 'package:stacked/stacked.dart';
import 'package:weather_app/common/navigation/navigation.dart';
import 'package:weather_app/pages/city_page/city_view_model.dart';
import 'package:weather_app/pages/home_page/home_view_model.dart';

class SplashViewModel extends BaseViewModel {

	SplashViewModel() {
		initializeApp();
	}

	void initializeApp() {
		Future.delayed(Duration(milliseconds: 800), () {
			Navigation.pushReplacement(AppPage.city, viewModel: CityViewModel());
		});
	}

}