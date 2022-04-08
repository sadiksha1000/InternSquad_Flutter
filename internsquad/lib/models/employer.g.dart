// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employer _$EmployerFromJson(Map<String, dynamic> json) => Employer(
      id: json['_id'] as String?,
      companyName: json['companyName'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      companyProfile: json['companyProfile'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$EmployerToJson(Employer instance) => <String, dynamic>{
      '_id': instance.id,
      'companyName': instance.companyName,
      'address': instance.address,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.image,
      'companyProfile': instance.companyProfile,
      'password': instance.password,
    };
