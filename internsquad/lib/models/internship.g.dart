// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Internship _$InternshipFromJson(Map<String, dynamic> json) => Internship(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      workEnvironment: json['workEnvironment'] as String?,
      startDate: json['startDate'] as String?,
      duration: json['duration']?.toString(),
      stipend: json['stipend']?.toString(),
      deadline: json['deadline'] as String?,
      internshipDetails: json['internshipDetails'] as String?,
      skills: json['skills'] as String?,
      whoCanApply: json['whoCanApply'] as String?,
      perks: json['perks'] as String?,
      numberOfOpenings: json['numberOfOpenings']?.toString(),
      isBookmarked: json['isBookmarked'] as String?,
      department: json['department'] as String?,
      internshipType: json['internshipType'] as String?,
      eid: json['eid'] == null
          ? null
          : Employer.fromJson(json['eid'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InternshipToJson(Internship instance) =>
    <String, dynamic>{
      '_id': instance.id,
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
      'isBookmarked': instance.isBookmarked,
      'department': instance.department,
      'internshipType': instance.internshipType,
      'eid': instance.eid,
    };
