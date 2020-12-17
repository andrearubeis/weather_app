import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/common/localization/app_localizations.dart';
import 'package:weather_app/common/navigation/navigation.dart';
import 'package:weather_app/model/open_weather_model/base_response.dart';

class ErrorInterceptor extends Interceptor {

// ignore: close_sinks
	static StreamController<WeatherError> errorStream = StreamController.broadcast();
	static Stream<WeatherError> errorStreamOut = errorStream.stream;

	@override
	Future onResponse(Response response) async {
		var jsonResponse = BaseResponse.fromJson(response.data);
		switch(jsonResponse.cod) {
			case "401" :
				var error = WeatherError(
					AppLocalizations.of(Navigation.navKey.currentState.overlay.context).appName
				);
				errorStream.add(error);
				break;
		}
		return response;
	}

}

class WeatherError {
	String message;

	WeatherError(this.message);
}