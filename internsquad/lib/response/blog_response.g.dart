// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogResponse _$BlogResponseFromJson(Map<String, dynamic> json) => BlogResponse(
      success: json['success'] as bool?,
      blog: (json['blog'] as List<dynamic>)
          .map((e) => Blog.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlogResponseToJson(BlogResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'blog': instance.blog.map((e) => e.toJson()).toList(),
    };
