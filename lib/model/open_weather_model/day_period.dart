import 'package:json_annotation/json_annotation.dart';

part 'day_period.g.dart';

@JsonSerializable()

class DayPeriod {
	String pod;

	DayPeriod({this.pod});

	factory DayPeriod.fromJson(Map<String, dynamic> json) => _$DayPeriodFromJson(json);

	Map<String, dynamic> toJson() => _$DayPeriodToJson(this);
}