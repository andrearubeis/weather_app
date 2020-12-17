// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_time_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateTimeWeather _$DateTimeWeatherFromJson(Map<String, dynamic> json) {
  return DateTimeWeather(
    dt: DateExtension.fromUnixUtc(json['dt'] as int),
    weatherDetail: json['main'] == null
        ? null
        : WeatherDetail.fromJson(json['main'] as Map<String, dynamic>),
    weather: (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : Weather.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    clouds: json['clouds'] == null
        ? null
        : Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
    wind: json['wind'] == null
        ? null
        : Wind.fromJson(json['wind'] as Map<String, dynamic>),
    visibility: json['visibility'] as int,
    pop: (json['pop'] as num)?.toDouble(),
    period: json['sys'] == null
        ? null
        : DayPeriod.fromJson(json['sys'] as Map<String, dynamic>),
    dtTxt: json['dtTxt'] as String,
  );
}

Map<String, dynamic> _$DateTimeWeatherToJson(DateTimeWeather instance) =>
    <String, dynamic>{
      'dt': instance.dt?.toIso8601String(),
      'main': instance.weatherDetail,
      'weather': instance.weather,
      'clouds': instance.clouds,
      'wind': instance.wind,
      'visibility': instance.visibility,
      'pop': instance.pop,
      'sys': instance.period,
      'dtTxt': instance.dtTxt,
    };
