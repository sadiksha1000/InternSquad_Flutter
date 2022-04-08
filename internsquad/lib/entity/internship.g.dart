// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Internships _$InternshipsFromJson(Map<String, dynamic> json) => Internships(
      pk: json['pk'] as int?,
      id: json['id'] as String?,
      title: json['title'] as String?,
      workEnvironment: json['workEnvironment'] as String?,
      deadline: json['deadline'] as String?,
      startDate: json['startDate'] as String?,
      duration: json['duration'] as String?,
      stipend: json['stipend'] as String?,
      department: json['department'] as String?,
      eid: json['eid'] as String?,
      internshipDetails: json['internshipDetails'] as String?,
      internshipType: json['internshipType'] as String?,
      numberOfOpenings: json['numberOfOpenings'] as String?,
      perks: json['perks'] as String?,
      skills: json['skills'] as String?,
      whoCanApply: json['whoCanApply'] as String?,
      address: json['address'] as String?,
      companyName: json['companyName'] as String?,
      companyProfile: json['companyProfile'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$InternshipsToJson(Internships instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'id': instance.id,
      'title': instance.title,
      'workEnvironment': instance.workEnvironment,
      'startDate': instance.startDate,
      'duration': instance.duration,
      'stipend': instance.stipend,
      'deadline': instance.deadline,
      'internshipDetails': instance.internshipDetails,
      'skills': instance.skills,
      'whoCanApply': instance.whoCanApply,
      'perks': instance.perks,
      'numberOfOpenings': instance.numberOfOpenings,
      'department': instance.department,
      'internshipType': instance.internshipType,
      'eid': instance.eid,
      'companyName': instance.companyName,
      'companyProfile': instance.companyProfile,
      'address': instance.address,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.image,
    };
