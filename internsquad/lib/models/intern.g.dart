// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intern.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Intern _$InternFromJson(Map<String, dynamic> json) => Intern(
      id: json['_id'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      image: json['image'] as String?,
      resume: json['resume'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$InternToJson(Intern instance) => <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'image': instance.image,
      'resume': instance.resume,
      'password': instance.password,
    };
