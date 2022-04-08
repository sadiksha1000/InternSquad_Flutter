import 'package:json_annotation/json_annotation.dart';

part 'employer.g.dart';

@JsonSerializable()
class Employer {
  @JsonKey(name: '_id')
  String? id;
  String? companyName;
  String? address;
  String? email;
  String? phone;
  String? image;
  String? companyProfile;
  String? password;

  Employer({
    this.id,
    this.companyName,
    this.address,
    this.email,
    this.phone,
    this.image,
    this.companyProfile,
    this.password,
  });

  factory Employer.fromJson(Map<String, dynamic> obj) =>
      _$EmployerFromJson(obj);
  Map<String, dynamic> toJson() => _$EmployerToJson(this);
}
