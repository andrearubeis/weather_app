import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/pages/splash_page/splash_view_model.dart';

class SplashPage extends StatefulWidget {

	final SplashViewModel _model;

	SplashPage(this._model);

  @override
  _SplashPageState createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {

	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder<SplashViewModel>.reactive(
			builder: (context, model, child) {
				return Scaffold(
					body: Center(
						child: Text(
							"SplashPage"
						),
					),
				);
			},
			viewModelBuilder: () => widget._model);
	}

}
