import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/common/style/app_theme.dart';
import 'package:weather_app/model/google_places_model/google_place.dart';

class CityCell extends StatelessWidget {

	final GooglePlace cityInformation;
	final Function onTap;

	CityCell(this.cityInformation, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
		child: Row(
		  children: [
		    CupertinoButton(
		    	padding: EdgeInsets.zero,
		    	onPressed: () {
		    		onTap(cityInformation);
				},
		    	child: Column(
		      	mainAxisSize: MainAxisSize.min,
		        crossAxisAlignment: CrossAxisAlignment.start,
		        children: [
		          Text(
		          	cityInformation.getCityName(),
		          	maxLines: 1,
		          	style: TextStyle(
		          		color: WeatherAppTheme.primaryText(context),
		          		fontSize: 30,
		          		fontWeight: FontWeight.bold
		          	),
		          ),
		      	  SizedBox(height: 8,),
		      	  Text(
		      		  "${cityInformation.getCityProvince()} ${(cityInformation.getCityState().isNotEmpty)? ", ${cityInformation.getCityState()}" : "" }",
		      		  maxLines: 1,
		      		  style: TextStyle(
		      			  color: WeatherAppTheme.primaryText(context),
		      			  fontSize: 15,
		      			  fontWeight: FontWeight.bold
		      		  ),
		      	  ),
		        ],
		      ),
		    ),
		  ],
		),
	);
  }
}
