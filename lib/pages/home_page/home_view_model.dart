import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/common/extension/date_time_extension.dart';
import 'package:weather_app/common/services/network_services.dart';
import 'package:weather_app/common/style/app_icons.dart';
import 'package:weather_app/model/google_places_model/google_place.dart';
import 'package:weather_app/model/open_weather_model/base_response.dart';
import 'package:weather_app/model/open_weather_model/date_time_weather.dart';

class HomeViewModel extends BaseViewModel with AppIcons {

	GooglePlace city;

	Future<List<List<DateTimeWeather>>> weatherOnDay;

	HomeViewModel(this.city) {
		weatherOnDay = fetchData();
	}

	Future<List<List<DateTimeWeather>>> fetchData() {
		return NetworkService.getForecast(city.getCityName()).then((response) {
			return parseResponse(response);
		});
	}

	List<List<DateTimeWeather>> parseResponse(BaseResponse response) {
		Map<DateTime, List<DateTimeWeather>> weatherOnDay = Map<DateTime, List<DateTimeWeather>>();
		response.dateTimeWeatherList.forEach((element) {
			DateTime date = element.dt;
			print(date.day.toString() + " " + date.month.toString());
			bool dayAlreadyPresent = false;
			Iterator<DateTime> iterator = weatherOnDay.keys.iterator;
			while(iterator.moveNext() && !dayAlreadyPresent) {
				if(iterator.current.isSameDay(date)) {
					dayAlreadyPresent = true;
					weatherOnDay[iterator.current].add(element);
				}
			}
			if(!dayAlreadyPresent) {
				weatherOnDay[date] = List<DateTimeWeather>();
				weatherOnDay[date].add(element);
			}
		});
		List<List<DateTimeWeather>> weatherList = List();
		weatherOnDay.forEach((key, value) {
			weatherList.add(value);
		});
		return weatherList;
	}



}

