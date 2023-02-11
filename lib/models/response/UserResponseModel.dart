// class CurrentUser {
//   String? role;
//   String? fullName;
//   String? email;
//   String? phone;
//   String? dateOfBirth;
//   String? streetAddress;
//   String? city;
//   Null? state;
//   String? identity;
//   String? verifyCode;
//   String? updatedAt;
//   String? createdAt;
//   int? id;
//
//   CurrentUser(
//       {this.role,
//         this.fullName,
//         this.email,
//         this.phone,
//         this.dateOfBirth,
//         this.streetAddress,
//         this.city,
//         this.state,
//         this.identity,
//         this.verifyCode,
//         this.updatedAt,
//         this.createdAt,
//         this.id});
//
//   User.fromJson(Map<String, dynamic> json) {
//     role = json['role'];
//     fullName = json['full_name'];
//     email = json['email'];
//     phone = json['phone'];
//     dateOfBirth = json['date_of_birth'];
//     streetAddress = json['street_address'];
//     city = json['city'];
//     state = json['state'];
//     identity = json['identity'];
//     verifyCode = json['verify_code'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['role'] = this.role;
//     data['full_name'] = this.fullName;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['date_of_birth'] = this.dateOfBirth;
//     data['street_address'] = this.streetAddress;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['identity'] = this.identity;
//     data['verify_code'] = this.verifyCode;
//     data['updated_at'] = this.updatedAt;
//     data['created_at'] = this.createdAt;
//     data['id'] = this.id;
//     return data;
//   }
// }