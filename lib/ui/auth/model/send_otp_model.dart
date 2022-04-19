// ignore_for_file: prefer_collection_literals, unnecessary_new, unnecessary_this

class SendOtpModel {
  String? response;
  String? message;
  Results? results;

  SendOtpModel({this.response, this.message, this.results});

  SendOtpModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    message = json['message'];
    results =
        json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['message'] = this.message;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class Results {
  String? oTPSession;

  Results({this.oTPSession});

  Results.fromJson(Map<String, dynamic> json) {
    oTPSession = json['OTPSession'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OTPSession'] = this.oTPSession;
    return data;
  }
}
