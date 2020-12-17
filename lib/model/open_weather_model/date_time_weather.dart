import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/common/extension/date_time_extension.dart';
import 'package:weather_app/model/open_weather_model/clouds.dart';
import 'package:weather_app/model/open_weather_model/day_period.dart';
import 'package:weather_app/model/open_weather_model/weather.dart';
import 'package:weather_app/model/open_weather_model/weather_detail.dart';
import 'package:weather_app/model/open_weather_model/wind.dart';

part 'date_time_weather.g.dart';

@JsonSerializable()

class DateTimeWeather {
	DateTime dt;
	@JsonKey(name: 'main')
	WeatherDetail weatherDetail;
	List<Weather> weather;
	Clouds clouds;
	Wind wind;
	int visibility;
	double pop;
	@JsonKey(name: 'sys')
	DayPeriod period;
	String dtTxt;

	DateTimeWeather(
		{this.dt,
			this.weatherDetail,
			this.weather,
			this.clouds,
			this.wind,
			this.visibility,
			this.pop,
			this.period,
			this.dtTxt});

	factory DateTimeWeather.fromJson(Map<String, dynamic> json) => _$DateTimeWeatherFromJson(json);

	Map<String, dynamic> toJson() => _$DateTimeWeatherToJson(this);
}
