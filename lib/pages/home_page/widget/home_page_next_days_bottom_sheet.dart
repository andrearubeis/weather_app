import 'package:flutter/cupertino.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:weather_app/common/localization/app_localizations.dart';
import 'package:weather_app/common/style/app_theme.dart';
import 'package:weather_app/common/widgets/custom_carousel.dart';
import 'package:weather_app/model/open_weather_model/date_time_weather.dart';
import 'package:intl/intl.dart';


class HomePageNextDaysBottomSheet extends StatelessWidget {

	final List<List<DateTimeWeather>> weatherInfo;
	final SolidController controller;

	HomePageNextDaysBottomSheet(this.weatherInfo, this.controller);

  @override
  Widget build(BuildContext context) {
    return SolidBottomSheet(
		controller: controller,
		maxHeight: MediaQuery
			.of(context)
			.size
			.height * 0.8,
		draggableBody: true,
		autoSwiped: true,
		elevation: 10,
		toggleVisibilityOnTap: true,
		headerBar: Container(
			color: WeatherAppTheme.basics1(context),
			height: 80,
			child: Center(
				child: Text(
					AppLocalizations
						.of(context)
						.nextDays,
					style: TextStyle(
						color: WeatherAppTheme.primaryText(context),
						fontSize: 24
					),
				),
			),
		),
		body: Container(
			child: Column(
				mainAxisSize: MainAxisSize.max,
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Expanded(
						child: ListView.separated(
							itemCount: weatherInfo.length,
							separatorBuilder: (BuildContext context, int index) {
								return Container(
									height: 64,
									child: Padding(
										padding: const EdgeInsets.only(left: 24),
										child: Stack(
											fit: StackFit.expand,
											children: [
												Align(
													alignment: Alignment(-1, 0),
													child: Text(
														"${DateFormat("dd MMMM").format(weatherInfo[index].first.dt)}",
														style: TextStyle(
															fontSize: 16,
															fontWeight: FontWeight.bold,
															color: WeatherAppTheme.primaryText(context)
														),
													),
												)
											],
										)
									),
								);
							},
							itemBuilder: (BuildContext context, int index) {
								if(index != 0) {
									return CustomCarousel(
										weatherInfo[index]
									);
								} else {
									return Container();
								}
							}
						)
					)
				],
			),
		),
	);
  }

}