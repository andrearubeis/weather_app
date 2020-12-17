import 'package:flutter/widgets.dart';
import 'package:weather_app/common/widgets/weather_hour_cell.dart';
import 'package:weather_app/model/open_weather_model/date_time_weather.dart';

class CustomCarousel extends StatelessWidget {

	final List<DateTimeWeather> daysWeatherInfo;

	CustomCarousel(this.daysWeatherInfo);

  @override
  Widget build(BuildContext context) {
    return buildCarousel(daysWeatherInfo);
  }

  Widget buildCarousel(List<DateTimeWeather> weatherInfo) {
	  return Padding(
		  padding: const EdgeInsets.only(left: 24, right: 24),
		  child: Container(
			  height: 100,
			  child: Row(
				  mainAxisSize: MainAxisSize.max,
				  children: [
					  Expanded(
						  child: ListView.separated(
							  itemCount: weatherInfo.length,
							  scrollDirection: Axis.horizontal,
							  separatorBuilder: (BuildContext context, int index) {
								  return SizedBox(
									  width: 16,
								  );
							  },
							  itemBuilder: (BuildContext context, int index) {
								  return WeatherHourCell(
									  weatherInfo[index]
								  );
							  }

						  ),
					  )

				  ],
			  ),
		  ),
	  );
  }
}
