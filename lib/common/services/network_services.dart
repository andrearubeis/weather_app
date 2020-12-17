import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/common/config/api_key.dart';
import 'package:weather_app/common/config/environment.dart';
import 'package:weather_app/common/helper/network_service_helper.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/model/open_weather_model/base_response.dart';
import 'package:weather_app/model/google_places_model/google_place.dart';

class NetworkService {

// ignore: missing_return
	static String get _baseUrlOpenWeather {
		switch (locator<Configuration>().environment) {
			case Flavor.PROD:
				return 'https://api.openweathermap.org/data/';
			case Flavor.TEST:
				return 'https://api.openweathermap.org/data/';
			case Flavor.DEV:
				return 'https://api.openweathermap.org/data/';
		}
	}

	// ignore: missing_return
	static String get _baseUrlGoogleMaps {
		switch (locator<Configuration>().environment) {
			case Flavor.PROD:
				return "https://maps.googleapis.com/maps/api/";
			case Flavor.TEST:
				return "https://maps.googleapis.com/maps/api/";
			case Flavor.DEV:
				return "https://maps.googleapis.com/maps/api/";
		}
	}


// ignore: missing_return
	static String get _openWeatherAPIVersion {
		switch (locator<Configuration>().environment) {
			case Flavor.PROD:
				return '2.5/';
			case Flavor.TEST:
				return '2.5/';
			case Flavor.DEV:
				return '2.5/';
		}
	}

	static const String openWeatherIconUrl = "http://openweathermap.org/img/wn/";

	static Map<String, dynamic> _header = Map();

	static setToken(String token) {
		_header["Authorization"] = "Bearer $token";
	}

	static clearToken() {
		_header.remove("Authorization");
	}

	static Future<BaseResponse> getForecast(String city) {
		String url = _baseUrlOpenWeather + _openWeatherAPIVersion + "forecast";
		Map<String, dynamic> data = {
			"q": city,
			"appid": ApiKey.openWeatherApiKey,
			"units": "metric"
		};

		return NetworkServiceHelper.get(url, data: data).then(
				(response) {
					return BaseResponse.fromJson(response);
				});

	}

	static Future<List<GooglePlace>> getPlaceWithAddress(String cityQuery) {
		String url = _baseUrlGoogleMaps + "place/autocomplete/json?";

		Map<String, dynamic> data = {
			"input": cityQuery,
			"types": "(cities)",
			"key": ApiKey.googleMapsApiKey,
		};
		return NetworkServiceHelper.get(url, data: data).then((json) {
			List<GooglePlace> placeList = (json["predictions"] as List)
				.map((item) => GooglePlace.fromJson(item))
				.toList();
			return placeList;
		});
	}

	/*static Future<Login> login(
		{@required String username, @required String password}) async {
		String url = _baseUrlLogin + "/token";
		Map data = {
			"username": "$username",
			"password": "$password",
			"grant_type": "password",
			"client_secret": _clientSecret,
			"client_id": _clientId
		};
		return NetworkServiceHelper.post(url, data, contentType: "application/x-www-form-urlencoded").then((json) {
			return Login.fromJson(json);
		}).catchError((onError) {
			throw onError;
		});
	}

	static Future<bool> logout() async {
		String url = _baseUrlLogin + "/logout";
		Map data = {
			"client_secret": _clientSecret,
			"client_id": _clientId,
			"refresh_token": locator<Profile>().refreshToken
		};

		return NetworkServiceHelper.post(url, data, contentType: "application/x-www-form-urlencoded").then((json) {
			if (json["status"] == "OK") {
				locator<Profile>().accessToken = null;
				return true;
			} else {
				return false;
			}
		}).catchError((onError) {
			throw onError;
		});
	}

	static Future<String> tokenRefresh(String refreshToken) {
		String url = _baseUrlLogin + "/token";
		Map data = {
			"grant_type": "refresh_token",
			"client_secret": _clientSecret,
			"client_id": _clientId,
			"refresh_token": refreshToken ?? locator<Profile>().refreshToken
		};
		return Dio()
			.post(url,
			data: data,
			options: Options(contentType: "application/x-www-form-urlencoded"))
			.then((json) {
			var map = jsonDecode(json.toString());
			var login = Login.fromJson(map);
			locator<Profile>().accessToken = login.accessToken;
			locator<Profile>().refreshToken = login.refreshToken;
			NetworkService.setToken(login.accessToken);
			return login.accessToken;
		}).catchError((onError) {
			throw onError;
		});
	}*/


}