import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/common/config/environment.dart';
import 'package:weather_app/common/interceptor/error_interceptor.dart';
import 'package:weather_app/main.dart';

class NetworkServiceHelper {

	static Dio http = Dio();

	static Future<Dio> getApiClient() async {

		http.interceptors.clear();
		http.interceptors.requestLock.unlock();
		http.interceptors.responseLock.unlock();
		http.interceptors.add(ErrorInterceptor());
		return http;
	}

	static Future<Map> post(String url, Map data,  {Map<String, dynamic> headers, bool logVisible = true,String contentType = "application/json"}) async {

		var apiClient = await getApiClient();

		if(locator<Configuration>().environment == Flavor.PROD) {
			logVisible = false;
		}

		if (!kReleaseMode) {
			log("---");
			log("REQUEST POST: $url");
			log("HEADERS: $headers");
			log("BODY:");
			_printJsonLogFromMap(data);
			log("---");
		}



		Response response;
		response = await apiClient.post(
			url,
			data: data,
			options: Options(contentType: contentType,
				headers: headers)
		).catchError(
				(error) {
				print(error);
				_manageError(error.response ,logVisible: logVisible);
			},
		);

		// check the status code
		return _manageError(response, logVisible: logVisible);
	}

	static Future<Map> get(String url, {Map<String, dynamic> headers, bool logVisible = true, String contentType = "application/json", Map data}) async {
		//Dio http = Dio();
		var apiClient = await getApiClient();

		if(locator<Configuration>().environment == Flavor.PROD) {
			logVisible = false;
		}

		if (!kReleaseMode) {
			log("---");
			log("REQUEST GET: $url");
			//log("HEADERS: $headers");
			log("QUERY PARAMS: $data");
			log("---");
		}


		Response response;
		response = await apiClient.get(
			url,
			queryParameters: data,
			options: Options(
				contentType: contentType,
			)
		).catchError(
				(error) {
				print(error);
				_manageError(error.response ,logVisible: logVisible);
			},
		);


		return _manageError(response);
	}

	static Future<Map> put(String url, {Map data, Map headers, bool logVisible = true ,String contentType = "application/json"}) async {
		//Dio http = Dio();
		var apiClient = await getApiClient();

		if(locator<Configuration>().environment == Flavor.PROD) {
			logVisible = false;
		}

		if (!kReleaseMode) {
			log("---");
			log("REQUEST PUT: $url");
			log("BODY:");
			_printJsonLogFromMap(data);
			log("---");
		}
		print("DATA BODY PUT $data");


		Response response;
		response = await apiClient.put(
			url,
			data: data,
			options: Options(
				contentType: contentType,
				headers: headers
			)
		).catchError(
				(error) {
				print(error);
				_manageError(error.response ,logVisible: logVisible);
			},
		);

		return _manageError(response, logVisible: logVisible);
	}

	static Future<Map> delete(String url,{Map headers, Map data, bool logVisible = true ,String contentType = "application/json"}) async {
		//Dio http = Dio();
		var apiClient = await getApiClient();

		if(locator<Configuration>().environment == Flavor.PROD) {
			logVisible = false;
		}

		if (!kReleaseMode) {
			log("---");
			log("REQUEST DELETE: $url");
			log("BODY:");
			_printJsonLogFromMap(data);
			log("---");
		}


		Response response;
		response = await apiClient.delete(
			url,
			data: data,
			options: Options(
				contentType: contentType,
				headers: headers
			)
		).catchError(
				(error) {
				print(error);
				_manageError(error.response ,logVisible: logVisible);
			},
		);

		return _manageError(response, logVisible: logVisible);
	}

	static Map _manageError(Response response, {bool logVisible = true}) {
		if (!kReleaseMode) {
			log("---");
			log("RESPONSE:");
			log("STATUS CODE: ${response.statusCode}");
			log("---");
		}

		switch (response.statusCode) {
			case 200:
			// parsing to json
				Map map = Map();
				JsonEncoder encoder = new JsonEncoder.withIndent('  ');
				String responseString = encoder.convert(response.data.toString());
				if(responseString != "\"Ok\"") {
					map = jsonDecode(response.toString());

					if(logVisible) {
						log("BODY:");
						_printJsonLogFromString(response.toString());
					}
				}
				return map;
				break;
			case 204:
				Map map = Map();
				return map;
				break;
			default:
				throw response;
				break;
		/*case 404:
				throw AppErrors(ErrorType.networkError, errorCode: response.statusCode);
				break;
			default:
				throw AppErrors(ErrorType.networkError, errorCode: response.statusCode);
				break;*/
		}
	}

	static void _printJsonLogFromString(String input) {
		var map = jsonDecode(input);
		_printJsonLogFromMap(map);
	}

	static void _printJsonLogFromMap(Map map) {
		JsonEncoder encoder = new JsonEncoder.withIndent('  ');
		String prettyPrint = encoder.convert(map);
		log(prettyPrint);
	}
}