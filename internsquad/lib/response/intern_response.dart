class InternResponse {
  bool? success;
  String? token;
  Map<String, dynamic>? intern;

  InternResponse({this.success, this.token, this.intern});

  factory InternResponse.fromJson(Map<String, dynamic> json) {
    return InternResponse(
        success: json['success'],
        token: json['token'],
        intern: json['internData']);
  }
}
