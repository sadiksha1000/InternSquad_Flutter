class EmployerResponse {
  bool? success;
  String? token;
  Map<String, dynamic>? employer;

  EmployerResponse({this.success, this.token, this.employer});

  factory EmployerResponse.fromJson(Map<String, dynamic> json) {
    return EmployerResponse(
      success: json['success'],
      token: json['token'],
      employer: json['employerData'],
    );
  }
}
