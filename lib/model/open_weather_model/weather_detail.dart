import 'package:json_annotation/json_annotation.dart';

part 'weather_detail.g.dart';

@JsonSerializable()

class WeatherDetail {
	double temp;
	@JsonKey(name: 'feels_like')
	double feelsLike;
	@JsonKey(name: 'temp_min')
	double tempMin;
	@JsonKey(name: 'temp_max')
	double tempMax;
	int humidity;

	WeatherDetail(
		{this.temp,
			this.feelsLike,
			this.tempMin,
			this.tempMax,
			this.humidity});

	factory WeatherDetail.fromJson(Map<String, dynamic> json) => _$WeatherDetailFromJson(json);

	Map<String, dynamic> toJson() => _$WeatherDetailToJson(this);
}
