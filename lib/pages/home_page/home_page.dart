import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/common/extension/string_extension.dart';
import 'package:weather_app/common/localization/app_localizations.dart';
import 'package:weather_app/common/style/app_theme.dart';
import 'package:weather_app/common/widgets/custom_app_bar.dart';
import 'package:weather_app/common/widgets/custom_carousel.dart';
import 'package:weather_app/common/widgets/loader.dart';
import 'package:weather_app/model/open_weather_model/date_time_weather.dart';
import 'package:weather_app/pages/home_page/home_view_model.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/pages/home_page/widget/home_page_next_days_bottom_sheet.dart';
import 'package:weather_app/pages/home_page/widget/min_max_temperature.dart';

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
						.primaryAccent(context),
				  body: FutureBuilder(
				  	future: model.weatherOnDay,
				  	builder: (BuildContext context,
				  		AsyncSnapshot<List<List<DateTimeWeather>>> snapshot) {
						Widget child;
						if (snapshot.connectionState == ConnectionState.waiting) {
							child = Container(
								color: WeatherAppTheme.primaryAccent(context),
								child: Loader()
							);
						} else {
							child = buildPageBody(model, snapshot.data);
						}

						return AnimatedSwitcher(
							duration: Duration(milliseconds: 350),
							child: child,
						);
				  	}
				  	),
					bottomSheet: FutureBuilder(
						future: model.weatherOnDay,
						builder: (BuildContext context, AsyncSnapshot<List<List<DateTimeWeather>>> snapshot) {
							if(snapshot.hasData) {
								return HomePageNextDaysBottomSheet(snapshot.data, _controller);
							} else {
								return Container(
									color: WeatherAppTheme.primaryAccent(context),
									child: Loader()
								);
							}
						},
					),
				);
			});
	}

	Widget buildPageBody(HomeViewModel model, List<List<DateTimeWeather>> weatherInfo) {
		return SafeArea(
			bottom: false,
			child: Column(
				mainAxisSize: MainAxisSize.max,
				crossAxisAlignment: CrossAxisAlignment
					.stretch,
				children: [
					CustomAppBar(),
					getDateAndCityInfo(
						model, weatherInfo.first),
					Expanded(
						flex: 4,
						child: buildTodayWeatherInfo(
							weatherInfo.first.first,
							model)
					),
					Spacer(
						flex: 1,
					),
					CustomCarousel(
						weatherInfo.first
					),
					Spacer(
						flex: 2,
					),
				],
			)
		);
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
					child: buildMinMaxTemperature(todayInfo.weatherDetail.tempMin, MinMaxTemperatureType.MIN)
				),
				Expanded(
					flex: 10,
					child: buildTodayInfoWithIcon(todayInfo, model)
				),
				Expanded(
					flex: 5,
				  child: buildMinMaxTemperature(todayInfo.weatherDetail.tempMax, MinMaxTemperatureType.MAX),
				),
			],
		);
	}

	Widget buildMinMaxTemperature(double temperature, MinMaxTemperatureType type) {
		return Stack(
			fit: StackFit.expand,
			children: [
				Align(
					alignment: Alignment((type == MinMaxTemperatureType.MIN)? 1 : -1, -0.1),
					child: MinMaxTemperature(temperature.floor().toString(), type)
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
