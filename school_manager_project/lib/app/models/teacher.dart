class Teacher {
  String? status;
  String? message;
  TeacherData? data;
  String? token;

  Teacher({this.status, this.message, this.data, this.token});

  Teacher.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? TeacherData.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class TeacherData {
  String? sId;
  String? teacherId;
  String? fullName;
  String? teacherCode;
  String? email;
  String? password;
  String? phoneNumber;
  String? gender;
  String? cccd;
  String? birthDate;
  String? birthPlace;
  String? ethnicity;
  String? nickname;
  String? teachingLevel;
  String? position;
  String? experience;
  String? department;
  String? role;
  String? joinDate;
  bool? civilServant;
  String? contractType;
  String? primarySubject;
  String? secondarySubject;
  bool? isWorking;
  String? academicDegree;
  String? standardDegree;
  String? politicalTheory;
  String? avatarUrl;
  int? iV;
  String? createdAt;
  String? updatedAt;

  TeacherData({
    this.sId,
    this.teacherId,
    this.fullName,
    this.teacherCode,
    this.email,
    this.password,
    this.phoneNumber,
    this.gender,
    this.cccd,
    this.birthDate,
    this.birthPlace,
    this.ethnicity,
    this.nickname,
    this.teachingLevel,
    this.position,
    this.experience,
    this.department,
    this.role,
    this.joinDate,
    this.civilServant,
    this.contractType,
    this.primarySubject,
    this.secondarySubject,
    this.isWorking,
    this.academicDegree,
    this.standardDegree,
    this.politicalTheory,
    this.avatarUrl,
    this.iV,
    this.createdAt,
    this.updatedAt,
  });

  TeacherData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    teacherId = json['teacherId'];
    fullName = json['fullName'];
    teacherCode = json['teacherCode'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    cccd = json['cccd'];
    birthDate = json['birthDate'];
    birthPlace = json['birthPlace'];
    ethnicity = json['ethnicity'];
    nickname = json['nickname'];
    teachingLevel = json['teachingLevel'];
    position = json['position'];
    experience = json['experience'];
    department = json['department'];
    role = json['role'];
    joinDate = json['joinDate'];
    civilServant = json['civilServant'];
    contractType = json['contractType'];
    primarySubject = json['primarySubject'];
    secondarySubject = json['secondarySubject'];
    isWorking = json['isWorking'];
    academicDegree = json['academicDegree'];
    standardDegree = json['standardDegree'];
    politicalTheory = json['politicalTheory'];
    avatarUrl = json['avatarUrl'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['teacherId'] = teacherId;
    data['fullName'] = fullName;
    data['teacherCode'] = teacherCode;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['gender'] = gender;
    data['cccd'] = cccd;
    data['birthDate'] = birthDate;
    data['birthPlace'] = birthPlace;
    data['ethnicity'] = ethnicity;
    data['nickname'] = nickname;
    data['teachingLevel'] = teachingLevel;
    data['position'] = position;
    data['experience'] = experience;
    data['department'] = department;
    data['role'] = role;
    data['joinDate'] = joinDate;
    data['civilServant'] = civilServant;
    data['contractType'] = contractType;
    data['primarySubject'] = primarySubject;
    data['secondarySubject'] = secondarySubject;
    data['isWorking'] = isWorking;
    data['academicDegree'] = academicDegree;
    data['standardDegree'] = standardDegree = standardDegree;
    data['politicalTheory'] = politicalTheory;
    data['avatarUrl'] = avatarUrl;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
