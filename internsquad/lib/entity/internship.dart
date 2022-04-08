import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'internship.g.dart';

@entity
@JsonSerializable()
class Internships {
  @PrimaryKey(autoGenerate: true)
  int? pk;
  String? id;
  String? title;
  String? workEnvironment;
  String? startDate;
  String? duration;
  String? stipend;
  String? deadline;
  String? internshipDetails;
  String? skills;
  String? whoCanApply;
  String? perks;
  String? numberOfOpenings;
  String? department;
  String? internshipType;
  String? eid;
  String? companyName;
  String? companyProfile;
  String? address;
  String? email;
  String? phone;
  String? image;

  Internships({
    this.pk,
    this.id,
    required this.title,
    required this.workEnvironment,
    required this.deadline,
    required this.startDate,
    required this.duration,
    required this.stipend,
    required this.department,
    required this.eid,
    required this.internshipDetails,
    required this.internshipType,
    required this.numberOfOpenings,
    required this.perks,
    required this.skills,
    required this.whoCanApply,
    required this.address,
    required this.companyName,
    required this.companyProfile,
    required this.email,
    required this.image,
    required this.phone,
  });

  factory Internships.fromJson(Map<String, dynamic> obj) =>
      _$InternshipsFromJson(obj);
  Map<String, dynamic> toJson() => _$InternshipsToJson(this);
}
