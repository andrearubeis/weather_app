import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/common/localization/app_localizations.dart';
import 'package:weather_app/common/style/app_theme.dart';
import 'package:weather_app/pages/city_page/city_view_model.dart';

class CityPage extends StatefulWidget {
	
	final CityViewModel _model;
	
	CityPage(this._model);
	
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {

	bool startPageBuild = false;

	@override
  void initState() {
    Future.delayed(Duration(milliseconds: 200), () {
    	setState(() {
    	  startPageBuild = true;
    	});
	});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
	  return ViewModelBuilder<CityViewModel>.reactive(
		  builder: (context, model, child) {
			  return Scaffold(
				  body: SafeArea(
					  bottom: false,
					  child: buildBody(model)
				  )
			  );
		  },
		  viewModelBuilder: () => widget._model);
  }

  Widget buildBody(CityViewModel model) {
	  return Column(
		  children: <Widget>[
			  Expanded(
				  flex: 5,
				  child: Padding(
					  padding: EdgeInsets.symmetric(horizontal: 24),
					  child: Stack(
						  fit: StackFit.expand,
						  children: <Widget>[
							  AnimatedAlign(
								  alignment: startPageBuild
									  ? Alignment(-1, 0.8)
									  : Alignment(-1, -1),
								  duration: Duration(
									  milliseconds: 200
								  ),
								  curve: Curves.decelerate,
								  child: AnimatedOpacity(
									  duration: Duration(
										  milliseconds: 200
									  ),
									  opacity: startPageBuild ? 1 : 0,
									  child: Text(
										  AppLocalizations
											  .of(context)
											  .cityPageTitle,
										  style: TextStyle(
											  fontSize: 50,
											  fontWeight: FontWeight.bold
										  ),
									  ),
								  ),
							  )
						  ],
					  ),
				  )
			  ),
			  Expanded(
				  flex: 1,
				  child: GestureDetector(
					  onTap: model.goToSearchCity,
					  child: Hero(
						  tag: "container_search",
					    child: Material(
							type: MaterialType.transparency,
					      child: Container(
						  color: WeatherAppTheme.primaryNttAccent(context),
						  child: Padding(
							  padding: EdgeInsets.symmetric(horizontal: 24),
							  child: Stack(
								  fit: StackFit.expand,
								  children: [
									  Align(
										  alignment: Alignment(-1, -0.4),
										  child: Text(
											  AppLocalizations
												  .of(context)
												  .cityPageSearchPlaceholder,
											  style: TextStyle(
												  fontSize: 24
											  ),
										  ),
									  )
								  ],
							  ),
						  )
					      ),
					    ),
					  ),
				  )
			  )
		  ],
	  );
  }
  
  }
  
  
