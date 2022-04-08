// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bookmark _$BookmarkFromJson(Map<String, dynamic> json) => Bookmark(
      id: json['_id'] as String?,
      internId: json['internId'] == null
          ? null
          : Intern.fromJson(json['internId'] as Map<String, dynamic>),
      internshipId: json['internshipId'] == null
          ? null
          : Internship.fromJson(json['internshipId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookmarkToJson(Bookmark instance) => <String, dynamic>{
      '_id': instance.id,
      'internId': instance.internId,
      'internshipId': instance.internshipId,
    };
