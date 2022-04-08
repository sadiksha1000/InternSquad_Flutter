import 'package:json_annotation/json_annotation.dart';

part 'intern.g.dart';

@JsonSerializable()
class Intern {
  @JsonKey(name: '_id')
  String? id;
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? image;
  String? resume;
  String? password;

  Intern({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.image,
    this.resume,
    this.password,
  });

  factory Intern.fromJson(Map<String, dynamic> obj) => _$InternFromJson(obj);
  Map<String, dynamic> toJson() => _$InternToJson(this);
}
