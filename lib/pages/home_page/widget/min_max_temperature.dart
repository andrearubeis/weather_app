import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/common/extension/string_extension.dart';


enum MinMaxTemperatureType {
	MIN,
	MAX
}

class MinMaxTemperature extends StatelessWidget {

	final String temperature;
	final MinMaxTemperatureType type;

	MinMaxTemperature(this.temperature, this.type);

  @override
  Widget build(BuildContext context) {
    return Row(
		mainAxisSize: MainAxisSize.min,
		children: [
			buildIcon(),
			Text(
				temperature.toDegreeFormat(),
				style: TextStyle(
					fontSize: 24,
				),
			),
	  ]
	);
  }

  buildIcon() {
  	switch(type) {
  	  case MinMaxTemperatureType.MIN:
  	    return RotatedBox(
			quarterTurns: 3,
			child: getIcon(),
		);
  	    break;
  	  case MinMaxTemperatureType.MAX:
		  return RotatedBox(
			  quarterTurns: 1,
			  child: getIcon(),
		  );
  	    break;
	}
  }

  Widget getIcon() {
  	return Icon(
		CupertinoIcons.backward
	);
  }


}
