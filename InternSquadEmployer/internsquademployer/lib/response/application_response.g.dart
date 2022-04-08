// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationResponse _$ApplicationResponseFromJson(Map<String, dynamic> json) =>
    ApplicationResponse(
      success: json['success'] as bool?,
      application: (json['application'] as List<dynamic>)
          .map((e) => Application.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApplicationResponseToJson(
        ApplicationResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'application': instance.application.map((e) => e.toJson()).toList(),
    };
