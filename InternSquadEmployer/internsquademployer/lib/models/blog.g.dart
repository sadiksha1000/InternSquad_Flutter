// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blog _$BlogFromJson(Map<String, dynamic> json) => Blog(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      uploadDate: json['uploadDate'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$BlogToJson(Blog instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'uploadDate': instance.uploadDate,
      'image': instance.image,
    };
