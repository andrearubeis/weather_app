import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
	int id;
	String name;
	String country;
	int population;
	int timezone;
	int sunrise;
	int sunset;

	City(
		{this.id,
			this.name,
			this.country,
			this.population,
			this.timezone,
			this.sunrise,
			this.sunset});

	factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

	Map<String, dynamic> toJson() => _$CityToJson(this);
}