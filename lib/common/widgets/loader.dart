import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/common/style/app_theme.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
			child: Container(
				height: 60,
				child: FlareActor("assets/rive/loader.flr",
					alignment:Alignment.center,
					animation:"active"
				),
			)
	);
  }
}
