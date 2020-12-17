import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/common/extension/string_extension.dart';
import 'package:weather_app/common/localization/app_localizations.dart';
import 'package:weather_app/common/style/app_theme.dart';
import 'package:weather_app/common/widgets/custom_app_bar.dart';
import 'package:weather_app/common/widgets/custom_carousel.dart';
import 'package:weather_app/common/widgets/weather_hour_cell.dart';
import 'package:weather_app/model/open_weather_model/date_time_weather.dart';
import 'package:weather_app/pages/home_page/home_view_model.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/pages/home_page/widget/home_page_next_days_bottom_sheet.dart';
import 'package:weather_app/pages/splash_page/splash_page.dart';

class HomePage extends StatefulWidget {

	final HomeViewModel _model;

	HomePage(this._model);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {

	SolidController _controller = SolidController();

	@override
  void initState() {
    super.initState();
  }

	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<HomeViewModel>.reactive(
			viewModelBuilder: () => widget._model,
			builder: (context, model, child) {
				return Scaffold(
					backgroundColor: WeatherAppTheme
						.primaryNttAccent(context),
				  body: FutureBuilder(
				  	future: model.weatherOnDay,
				  	builder: (BuildContext context,
				  		AsyncSnapshot<List<List<DateTimeWeather>>> snapshot) {
						if (snapshot.hasData) {
							return SafeArea(
							  		bottom: false,
							  		child: Column(
							  			mainAxisSize: MainAxisSize.max,
							  			crossAxisAlignment: CrossAxisAlignment
							  				.stretch,
							  			children: [
							  				CustomAppBar(),
							  				getDateAndCityInfo(
							  					model, snapshot.data.first),
							  				Expanded(
							  					flex: 4,
							  					child: buildTodayWeatherInfo(
							  						snapshot.data.first.first,
							  						model)
							  				),
							  				Spacer(
							  					flex: 1,
							  				),
							  				CustomCarousel(
							  					snapshot.data.first
							  				),
							  				Spacer(
							  					flex: 2,
							  				),
							  			],
							  		)
							);
						} else {
							return Container(
								color: WeatherAppTheme.primaryNttAccent(context),
							);
						}
				  	}
				  	),
					bottomSheet: FutureBuilder(
						future: model.weatherOnDay,
						builder: (BuildContext context, AsyncSnapshot<List<List<DateTimeWeather>>> snapshot) {
							if(snapshot.hasData) {
								return HomePageNextDaysBottomSheet(snapshot.data, _controller);
							} else {
								return Container(
									color: WeatherAppTheme.primaryNttAccent(context),
								);
							}
						},
					),
				);
			});
	}
	
	Widget getDateAndCityInfo(HomeViewModel model, List<DateTimeWeather> weatherList) {
		return Column(
			mainAxisSize: MainAxisSize.min,
			crossAxisAlignment: CrossAxisAlignment.center,
			children: [
				Text(
					"${AppLocalizations.of(context).today} ${DateFormat("dd MMM").format(weatherList.first.dt)}",
					style: TextStyle(
						fontSize: 16,
						color: WeatherAppTheme.primaryText(context)
					)
				),
				Text(
					model.city.getCityName(),
					style: TextStyle(
						height: 1.5,
						fontSize: 32,
						fontWeight: FontWeight.bold,
						color: WeatherAppTheme.primaryText(context)
					),
				),
			],
		);
	}

	Widget buildTodayWeatherInfo(DateTimeWeather todayInfo, HomeViewModel model) {
		return Row(
			mainAxisSize: MainAxisSize.max,
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Expanded(
					flex: 5,
					child: buildMinMaxTemperature(todayInfo.weatherDetail.tempMin)
				),
				Expanded(
					flex: 10,
					child: buildTodayInfoWithIcon(todayInfo, model)
				),
				Expanded(
					flex: 5,
				  child: buildMinMaxTemperature(todayInfo.weatherDetail.tempMax),
				),
			],
		);
	}

	Widget buildMinMaxTemperature(double temperature) {
		return Stack(
			fit: StackFit.expand,
			children: [
				Align(
					alignment: Alignment(0, -0.1),
					child: Text(
						temperature.floor().toString().toDegreeFormat(),
						style: TextStyle(
							fontSize: 24,
						),
					),
				)
			],
		);
	}

	Widget buildTodayInfoWithIcon(DateTimeWeather todayInfo, HomeViewModel model) {
		return Stack(
			fit: StackFit.expand,
			children: [
				Align(
					alignment: Alignment(0,0),
					child: Text(
						todayInfo.weatherDetail.temp.floor().toString().toDegreeFormat(),
						style: TextStyle(
							color: WeatherAppTheme.secondaryText(context),
							fontSize: 100,
						),
					),
				),
				Align(
					alignment: Alignment(0,1),
					child: Image.network(
						model.getIconUrl(todayInfo.weather.first.icon)
					),
				)
			],
		);
	}



}
