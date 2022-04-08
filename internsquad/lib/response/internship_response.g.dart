// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internship_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InternshipResponse _$InternshipResponseFromJson(Map<String, dynamic> json) =>
    InternshipResponse(
      success: json['success'] as bool?,
      internship: (json['internship'] as List<dynamic>)
          .map((e) => Internship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InternshipResponseToJson(InternshipResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'internship': instance.internship.map((e) => e.toJson()).toList(),
    };
