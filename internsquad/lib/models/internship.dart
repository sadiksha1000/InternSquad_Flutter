import './employer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'internship.g.dart';

@JsonSerializable()
class Internship {
  @JsonKey(name: '_id')
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
  String? isBookmarked;
  String? department;
  String? internshipType;
  Employer? eid;

  Internship({
    this.id,
    this.title,
    this.workEnvironment,
    this.startDate,
    this.duration,
    this.stipend,
    this.deadline,
    this.internshipDetails,
    this.skills,
    this.whoCanApply,
    this.perks,
    this.numberOfOpenings,
    this.isBookmarked,
    this.department,
    this.internshipType,
    this.eid,
  });

  factory Internship.fromJson(Map<String, dynamic> obj) =>
      _$InternshipFromJson(obj);
  Map<String, dynamic> toJson() => _$InternshipToJson(this);
}
