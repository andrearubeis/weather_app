import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/model/google_places_model/google_place_terms.dart';

part 'google_place.g.dart';

@JsonSerializable()
class GooglePlace {
	String description;
	List<GooglePlaceTerms> terms;

	GooglePlace({this.description, this.terms});

	String getCityName() {
		if(this.terms.length >= 1) {
			return this.terms[0].value;
		}
		return "";
	}

	String getCityProvince() {
		if(this.terms.length >= 2) {
			return this.terms[1].value;
		}
		return "";
	}

	String getCityState() {
		if(this.terms.length >= 3) {
			return this.terms[2].value;
		}
		return "";
	}

	factory GooglePlace.fromJson(Map<String, dynamic> json) => _$GooglePlaceFromJson(json);

	Map<String, dynamic> toJson() => _$GooglePlaceToJson(this);
}

