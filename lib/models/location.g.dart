// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      id: json['id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
      user_itinerary_summary: json['user_itinerary_summary'] as String,
      tour_package_name: json['tour_package_name'] as String,
      facts: (json['facts'] as List<dynamic>?)
          ?.map((e) => LocationFact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'user_itinerary_summary': instance.user_itinerary_summary,
      'tour_package_name': instance.tour_package_name,
      'facts': instance.facts,
    };
