import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/model/open_weather_model/city.dart';
import 'package:weather_app/model/open_weather_model/date_time_weather.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
	String cod;
	int message;
	int cnt;
	@JsonKey(name: 'list')
	List<DateTimeWeather> dateTimeWeatherList;
	City city;

	BaseResponse({this.cod, this.message, this.cnt, this.dateTimeWeatherList, this.city});

	factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);

	Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}