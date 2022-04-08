import 'package:internsquademployer/models/internship.dart';
import 'package:json_annotation/json_annotation.dart';

part 'internship_response.g.dart';

@JsonSerializable(explicitToJson: true)
class InternshipResponse {
  bool? success;
  final List<Internship> internship;

  InternshipResponse({this.success, required this.internship});

  factory InternshipResponse.fromJson(Map<String, dynamic> obj) =>
      _$InternshipResponseFromJson(obj);
  Map<String, dynamic> toJson() => _$InternshipResponseToJson(this);
}
