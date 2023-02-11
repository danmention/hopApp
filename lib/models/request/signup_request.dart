class SignupRequest {
  String? fullname;
  String? password;
  String? gender;
  String? phone;
  String? email;
  String? dateOfBirth;
  String? streetAddress;
  String? state;
  String? city;

  SignupRequest(
      {this.fullname,
        this.password,
        this.gender,
        this.phone,
        this.email,
        this.dateOfBirth,
        this.streetAddress,
        this.state,
        this.city});

  SignupRequest.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    password = json['password'];
    gender = json['gender'];
    phone = json['phone'];
    email = json['email'];
    dateOfBirth = json['DateOfBirth'];
    streetAddress = json['StreetAddress'];
    state = json['state'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['DateOfBirth'] = this.dateOfBirth;
    data['StreetAddress'] = this.streetAddress;
    data['state'] = this.state;
    data['city'] = this.city;
    return data;
  }
}
