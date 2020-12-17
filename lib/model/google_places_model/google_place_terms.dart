import 'package:json_annotation/json_annotation.dart';

part 'google_place_terms.g.dart';

@JsonSerializable()
class GooglePlaceTerms {
	int offset;
	String value;

	GooglePlaceTerms({this.offset, this.value});

	factory GooglePlaceTerms.fromJson(Map<String, dynamic> json) => _$GooglePlaceTermsFromJson(json);

	Map<String, dynamic> toJson() => _$GooglePlaceTermsToJson(this);
}