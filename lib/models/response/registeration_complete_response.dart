class SignupCompleteResponse {
  int? id;
  String? fullName;
  Null? gender;
  String? email;
  String? identity;
  String? availability;
  String? phone;
  String? dateOfBirth;
  Null? streetAddress;
  String? city;
  String? state;
  Null? profileImage;
  Null? locationAddress;
  String? role;
  String? hopCategoryId;
  Null? isLeader;
  Null? leaderId;
  Null? leaderBranch;
  int? areaId;
  String? areaName;
  Null? facebook;
  Null? instagram;
  Null? workExperience;
  String? isAdmin;
  int? status;
  String? verifyCode;
  Null? isVerified;
  String? createdAt;
  String? updatedAt;

  SignupCompleteResponse(
      {this.id,
        this.fullName,
        this.gender,
        this.email,
        this.identity,
        this.availability,
        this.phone,
        this.dateOfBirth,
        this.streetAddress,
        this.city,
        this.state,
        this.profileImage,
        this.locationAddress,
        this.role,
        this.hopCategoryId,
        this.isLeader,
        this.leaderId,
        this.leaderBranch,
        this.areaId,
        this.areaName,
        this.facebook,
        this.instagram,
        this.workExperience,
        this.isAdmin,
        this.status,
        this.verifyCode,
        this.isVerified,
        this.createdAt,
        this.updatedAt});

  SignupCompleteResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    gender = json['gender'];
    email = json['email'];
    identity = json['identity'];
    availability = json['availability'];
    phone = json['phone'];
    dateOfBirth = json['date_of_birth'];
    streetAddress = json['street_address'];
    city = json['city'];
    state = json['state'];
    profileImage = json['profile_image'];
    locationAddress = json['Location_address'];
    role = json['role'];
    hopCategoryId = json['hop_category_id'];
    isLeader = json['is_leader'];
    leaderId = json['leader_id'];
    leaderBranch = json['leader_branch'];
    areaId = json['area_id'];
    areaName = json['area_name'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    workExperience = json['work_experience'];
    isAdmin = json['is_admin'];
    status = json['status'];
    verifyCode = json['verify_code'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['identity'] = this.identity;
    data['availability'] = this.availability;
    data['phone'] = this.phone;
    data['date_of_birth'] = this.dateOfBirth;
    data['street_address'] = this.streetAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['profile_image'] = this.profileImage;
    data['Location_address'] = this.locationAddress;
    data['role'] = this.role;
    data['hop_category_id'] = this.hopCategoryId;
    data['is_leader'] = this.isLeader;
    data['leader_id'] = this.leaderId;
    data['leader_branch'] = this.leaderBranch;
    data['area_id'] = this.areaId;
    data['area_name'] = this.areaName;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['work_experience'] = this.workExperience;
    data['is_admin'] = this.isAdmin;
    data['status'] = this.status;
    data['verify_code'] = this.verifyCode;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
