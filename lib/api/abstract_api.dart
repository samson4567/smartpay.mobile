

class AbstractApiResponse {
  AbstractApiResponse({this.status, this.message, this.data});

  AbstractApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  bool? status;
  String? message;
  dynamic data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}

AbstractApiResponse handleResponse(dynamic response) {
  return AbstractApiResponse.fromJson(response.data);
}
