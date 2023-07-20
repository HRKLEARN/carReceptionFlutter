class BaseResponse {
  dynamic result;
  List? error;
  int? success;

  BaseResponse({this.result, this.error, this.success});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      result: json['result'],
      error: json['error'] != null
          ? (json['error'] as List).map((i) => i).toList()
          : null,
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['success'] = success;
    if (this.result != null) {
      result['result'] = this.result.toJson();
    }

    if (error != null) {
      result['error'] = error!.map((v) => v).toList();
    }
    return result;
  }
}
