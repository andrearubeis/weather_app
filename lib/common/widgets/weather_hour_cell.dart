import 'package:flutter/material.dart';
import 'package:weather_app/common/localization/app_localizations.dart';
import 'package:weather_app/common/style/app_icons.dart';
import 'package:weather_app/model/open_weather_model/date_time_weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/common/extension/string_extension.dart';


class WeatherHourCell extends StatelessWidget with AppIcons {

	final DateTimeWeather weatherInfo;

	WeatherHourCell(this.weatherInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
		height: 90,
		width: 60,
		child: Column(
			mainAxisSize: MainAxisSize.max,
			crossAxisAlignment: CrossAxisAlignment.center,
			children: [
				Text(
					"${DateFormat("HH : mm", "it").format(weatherInfo.dt)}",
				),
				Image.network(
					getIconUrl(weatherInfo.weather.first.icon)
				),
				Text(
					"${weatherInfo.weatherDetail.temp.floor().toString().toDegreeFormat()}C"
				)
			],
		),
	);
  }

}
