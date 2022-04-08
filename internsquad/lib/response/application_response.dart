import 'package:internsquad/models/application.dart';
import 'package:json_annotation/json_annotation.dart';

part 'application_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ApplicationResponse {
  bool? success;
  final List<Application> application;

  ApplicationResponse({this.success, required this.application});

  factory ApplicationResponse.fromJson(Map<String, dynamic> obj) =>
      _$ApplicationResponseFromJson(obj);
  Map<String, dynamic> toJson() => _$ApplicationResponseToJson(this);
}
