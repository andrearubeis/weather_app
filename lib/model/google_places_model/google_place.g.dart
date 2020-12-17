// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GooglePlace _$GooglePlaceFromJson(Map<String, dynamic> json) {
  return GooglePlace(
    description: json['description'] as String,
    terms: (json['terms'] as List)
        ?.map((e) => e == null
            ? null
            : GooglePlaceTerms.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GooglePlaceToJson(GooglePlace instance) =>
    <String, dynamic>{
      'description': instance.description,
      'terms': instance.terms,
    };
