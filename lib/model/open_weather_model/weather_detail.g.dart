// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDetail _$WeatherDetailFromJson(Map<String, dynamic> json) {
  return WeatherDetail(
    temp: (json['temp'] as num)?.toDouble(),
    feelsLike: (json['feels_like'] as num)?.toDouble(),
    tempMin: (json['temp_min'] as num)?.toDouble(),
    tempMax: (json['temp_max'] as num)?.toDouble(),
    humidity: json['humidity'] as int,
  );
}

Map<String, dynamic> _$WeatherDetailToJson(WeatherDetail instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'humidity': instance.humidity,
    };
