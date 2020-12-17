import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/common/localization/app_localizations.dart';
import 'package:weather_app/common/style/app_theme.dart';
import 'package:weather_app/common/widgets/city_cell.dart';
import 'package:weather_app/model/google_places_model/google_place.dart';
import 'package:weather_app/pages/search_city_page/search_city_view_model.dart';

class SearchCityPage extends StatefulWidget {

	final SearchCityViewModel _model;

	SearchCityPage(this._model);

  @override
  _SearchCityPageState createState() => _SearchCityPageState();
}

class _SearchCityPageState extends State<SearchCityPage> {

	TextEditingController textController;


	@override
  void initState() {
    super.initState();
  }

	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<SearchCityViewModel>.reactive(
			builder: (context, model, child) {
				return Scaffold(
					body: SafeArea(
						top: false,
						child: buildBody(model)
					)
				);
			},
			viewModelBuilder: () => widget._model);
	}

	Widget buildBody(SearchCityViewModel model) {
		return Column(
			children: <Widget>[
				Expanded(
					flex: 3,
					child: Hero(
						tag: "container_search",
						child: Material(
							type: MaterialType.transparency,
							child: Container(
								color: WeatherAppTheme.primaryNttAccent(
									context),
								child: Padding(
									padding: EdgeInsets.only(left: 24, right: 24, top: 48),
								  child: Column(
								  	mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								  	crossAxisAlignment: CrossAxisAlignment.stretch,
								  	mainAxisSize: MainAxisSize.max,
								  	children: [
								  		Text(
								  			AppLocalizations
								  				.of(context)
								  				.cityPageSearchPlaceholder,
								  			style: TextStyle(
								  				fontSize: 15
								  			),
								  		),
								  		TextField(
											autofocus: true,
											onChanged: model.fetchPlaces,
								  			style: TextStyle(
												fontSize: 24,
												color: WeatherAppTheme.primaryText(context)
											),
								  			decoration: InputDecoration(
												contentPadding: EdgeInsets.zero,
								  				border: OutlineInputBorder(
								  					borderRadius: BorderRadius.circular(12),
								  					borderSide: BorderSide(
								  						style: BorderStyle.none,
								  						color: Colors.transparent,
								  						width: 0
								  					),
								  				),
								  				enabledBorder: OutlineInputBorder(
								  					borderRadius: BorderRadius.circular(12),
								  					borderSide: BorderSide(
								  						style: BorderStyle.none,
								  						color: Colors.transparent,
								  						width: 0
								  					),
								  				),
								  				focusedBorder: OutlineInputBorder(
								  					borderRadius: BorderRadius.circular(12),
								  					borderSide: BorderSide(
								  						style: BorderStyle.none,
								  						color: Colors.transparent,
								  						width: 0
								  					),
								  				),
								  			),
								  		)
								  	],
								  ),
								),
							),
						),
					)
				),
				Expanded(
					flex: 7,
					child: Padding(
						padding: EdgeInsets.symmetric(horizontal: 24),
						child: StreamBuilder(
							stream: model.googlePlacesStreamOut,
							builder: (BuildContext context, AsyncSnapshot<List<GooglePlace>> snapshot) {
								if(snapshot.hasData) {
									if(snapshot.data.length != 0) {
										return ListView.separated(
											itemCount: snapshot.data.length,
											separatorBuilder: (
												BuildContext context,
												int index) {
												return SizedBox(
													height: 16,
												);
											},
											itemBuilder: (BuildContext context,
												int index) {
												return CityCell(
													snapshot.data[index],
													model.goToCityWeatherDetail
												);
											},
										);
									} else {
										return Column(
											crossAxisAlignment: CrossAxisAlignment.stretch,
										  	mainAxisAlignment: MainAxisAlignment.center,
										  children: [
											  Text(
												  AppLocalizations.of(context).cityPageSearchNoResult,
												  maxLines: 1,
												  textAlign: TextAlign.start,
												  style: TextStyle(
													  color: WeatherAppTheme.primaryText(context),
													  fontSize: 30,
													  fontWeight: FontWeight.bold
												  ),
											  ),
										  ],
										);
									}
								} else {
									return Container();
								}
							},
						)
					)
				)
			],
		);
	}

}
