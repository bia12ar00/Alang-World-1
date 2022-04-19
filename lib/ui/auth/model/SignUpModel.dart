class SignUpModel {
  String? response;
  String? message;
  Results? results;

  SignUpModel({this.response, this.message, this.results});

  SignUpModel.fromJson(Map<String, dynamic> json) {
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
  String? token;
  String? oTPSession;
  User? user;

  Results({this.token, this.oTPSession, this.user});

  Results.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    oTPSession = json['OTPSession'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['OTPSession'] = this.oTPSession;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? email;
  int? contactVerified;
  String? updatedAt;
  String? createdAt;
  int? id;
  List<Roles>? roles;
  List<Null>? authAccessToken;
  UserDetails? userDetails;

  User(
      {this.name,
      this.email,
      this.contactVerified,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.roles,
      this.authAccessToken,
      this.userDetails});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    contactVerified = json['contact_verified'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    // if (json['auth_access_token'] != null) {
    //   authAccessToken = <Null>[];
    //   json['auth_access_token'].forEach((v) {
    //     authAccessToken!.add(new Null.fromJson(v));
    //   });
    // }
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact_verified'] = this.contactVerified;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    // if (this.authAccessToken != null) {
    //   data['auth_access_token'] =
    //    //   this.authAccessToken!.map((v) => v.toJson()).toList();
    // }
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? guardName;
  String? createdAt;
  String? updatedAt;
  String? trial848;
  Pivot? pivot;

  Roles(
      {this.id,
      this.name,
      this.guardName,
      this.createdAt,
      this.updatedAt,
      this.trial848,
      this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    trial848 = json['trial848'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['guard_name'] = this.guardName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['trial848'] = this.trial848;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  String? modelId;
  String? roleId;
  String? modelType;

  Pivot({this.modelId, this.roleId, this.modelType});

  Pivot.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    roleId = json['role_id'];
    modelType = json['model_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_id'] = this.modelId;
    data['role_id'] = this.roleId;
    data['model_type'] = this.modelType;
    return data;
  }
}

class UserDetails {
  String? userId;
  Null? officeNumber;
  Null? profileImage;
  String? gender;
  String? address;
  String? userRole;
  String? mobile;
  String? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? company;
  Null? contractForm;
  Null? addressProof;
  Null? shift;
  String? token;
  String? tokenExpiredDate;
  int? id;
  String? district;
  String? state;
  String? country;
  String? uniqueId;
  String? pincode;
  Null? trial848;
  Null? dob;
  Null? establishmentDate;
  String? wallet;
  String? firebaseId;

  UserDetails(
      {this.userId,
      this.officeNumber,
      this.profileImage,
      this.gender,
      this.address,
      this.userRole,
      this.mobile,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.company,
      this.contractForm,
      this.addressProof,
      this.shift,
      this.token,
      this.tokenExpiredDate,
      this.id,
      this.district,
      this.state,
      this.country,
      this.uniqueId,
      this.pincode,
      this.trial848,
      this.dob,
      this.establishmentDate,
      this.wallet,
      this.firebaseId});

  UserDetails.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    officeNumber = json['office_number'];
    profileImage = json['profile_image'];
    gender = json['gender'];
    address = json['address'];
    userRole = json['user_role'];
    mobile = json['mobile'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    company = json['company'];
    contractForm = json['contract_form'];
    addressProof = json['address_proof'];
    shift = json['shift'];
    token = json['token'];
    tokenExpiredDate = json['token_expired_date'];
    id = json['id'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    uniqueId = json['unique_id'];
    pincode = json['pincode'];
    trial848 = json['trial848'];
    dob = json['dob'];
    establishmentDate = json['establishment_date'];
    wallet = json['wallet'];
    firebaseId = json['firebase_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['office_number'] = this.officeNumber;
    data['profile_image'] = this.profileImage;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['user_role'] = this.userRole;
    data['mobile'] = this.mobile;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['company'] = this.company;
    data['contract_form'] = this.contractForm;
    data['address_proof'] = this.addressProof;
    data['shift'] = this.shift;
    data['token'] = this.token;
    data['token_expired_date'] = this.tokenExpiredDate;
    data['id'] = this.id;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['unique_id'] = this.uniqueId;
    data['pincode'] = this.pincode;
    data['trial848'] = this.trial848;
    data['dob'] = this.dob;
    data['establishment_date'] = this.establishmentDate;
    data['wallet'] = this.wallet;
    data['firebase_id'] = this.firebaseId;
    return data;
  }
}
