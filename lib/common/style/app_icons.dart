import 'package:weather_app/common/services/network_services.dart';

class AppIcons {

	getIconUrl(String iconName) {
		return NetworkService.openWeatherIconUrl + iconName + "@2x.png";
	}

}