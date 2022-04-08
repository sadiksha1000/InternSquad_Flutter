// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Application _$ApplicationFromJson(Map<String, dynamic> json) => Application(
      id: json['_id'] as String?,
      internId: json['internId'] == null
          ? null
          : Intern.fromJson(json['internId'] as Map<String, dynamic>),
      internshipId: json['internshipId'] == null
          ? null
          : Internship.fromJson(json['internshipId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApplicationToJson(Application instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'internId': instance.internId,
      'internshipId': instance.internshipId,
    };
