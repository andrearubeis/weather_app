import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/common/navigation/navigation.dart';
import 'package:weather_app/common/style/app_theme.dart';

class CustomAppBar extends StatelessWidget {

	CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
		height: 60,
		child: Row(
			children: [
				CupertinoButton(
					onPressed: () {
						Navigation.pop();
					},
				  child: Icon(
				  	CupertinoIcons.back,
					  color: WeatherAppTheme.primaryText(context),
				  ),
				)
			],
		),
	);
  }
}
