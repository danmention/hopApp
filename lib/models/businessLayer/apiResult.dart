



class APIResult<T> {
  String? resp_code;
  //String? status;
  //bool ?isDisplayMessage;
  String ?resp_message;
  String ?resp_description;
  T? recordList;
  int? totalRecords;
  dynamic value;
  Error? errors;

  APIResult({
    this.resp_code,
    //this.isDisplayMessage,
    this.resp_message,
    this.recordList,
    this.totalRecords,
    this.value,
    this.errors,
    this.resp_description
  });

  factory APIResult.fromJson(Map<String, dynamic> json, T _recordList) => new APIResult(
        resp_code: json["resp_code"].toString(),
       // isDisplayMessage: json['isDisplayMessage'],
        resp_message: json["resp_message"],
         resp_description: json["resp_description"],
        recordList: _recordList,
        totalRecords: json["totalRecords"] != null ? json["totalRecords"] : null,
        value: json["value"] == null ? null : json["value"],
        errors: json["errors"] != null ? Error.fromJson(json["errors"]) : null,
      );
}


class Error {
  bool? success;
  String? message;
  String? resp_code;
  List<Errors>? errors;

  Error({this.success, this.message, this.resp_code, this.errors});

  Error.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    resp_code = "04";
    message = json['message'];
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(new Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Errors {
  String? field;
  String? message;

  Errors({this.field, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['message'] = this.message;
    return data;
  }
}





// class Error {
//   String? apiName;
//   String? apiType;
//   String? fileName;
//   dynamic functionName;
//   dynamic lineNumber;
//   dynamic typeName;
//   String? stack;
//
//   Error({
//     this.apiName,
//     this.apiType,
//     this.fileName,
//     this.functionName,
//     this.lineNumber,
//     this.typeName,
//     this.stack,
//   });
//
//   factory Error.fromJson(Map<String, dynamic> json) => new Error(
//         apiName: json["apiName"],
//         apiType: json["apiType"],
//         fileName: json["fileName"],
//         functionName: json["functionName"],
//         lineNumber: json["lineNumber"],
//         typeName: json["typeName"],
//         stack: json["stack"],
//       );
// }
