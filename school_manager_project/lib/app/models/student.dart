class Student {
  String? status;
  String? message;
  StudentData? data;

  Student({this.status, this.message, this.data});

  Student.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? StudentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class StudentData {
  String? sId;
  String? studentId;
  String? gmail;
  String? phone;
  String? fullName;
  String? birthDate;
  String? cccd;
  String? birthPlace;
  String? customYear;
  String? mssv;
  String? password;
  String? gender;
  String? hometown;
  String? permanentAddress;
  String? occupation;
  String? classStudent;
  List<StudentData>? students;
  String? contactPhone;
  String? contactAddress;
  String? educationLevel;
  List<String>? graduationCertificate;
  String? academicPerformance;
  String? conduct;
  String? classRanking10;
  String? classRanking11;
  String? classRanking12;
  String? graduationYear;
  String? ethnicity;
  String? religion;
  String? beneficiary;
  String? area;
  String? idCardIssuedDate;
  String? idCardIssuedPlace;
  String? fatherFullName;
  String? motherFullName;
  String? notes;
  bool? isStudying;
  String? avatarUrl;
  String? createdAt;
  String? updatedAt;
  int? iV;

  StudentData({
    this.sId,
    this.studentId,
    this.gmail,
    this.phone,
    this.fullName,
    this.birthDate,
    this.cccd,
    this.birthPlace,
    this.customYear,
    this.mssv,
    this.password,
    this.gender,
    this.hometown,
    this.permanentAddress,
    this.occupation,
    this.classStudent,
    this.students,
    this.contactPhone,
    this.contactAddress,
    this.educationLevel,
    this.graduationCertificate,
    this.academicPerformance,
    this.conduct,
    this.classRanking10,
    this.classRanking11,
    this.classRanking12,
    this.graduationYear,
    this.ethnicity,
    this.religion,
    this.beneficiary,
    this.area,
    this.idCardIssuedDate,
    this.idCardIssuedPlace,
    this.fatherFullName,
    this.motherFullName,
    this.notes,
    this.isStudying,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  StudentData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    studentId = json['studentId'];
    gmail = json['gmail'];
    phone = json['phone'];
    fullName = json['fullName'];
    birthDate = json['birthDate'];
    cccd = json['cccd'];
    birthPlace = json['birthPlace'];
    customYear = json['customYear'];
    mssv = json['mssv'];
    password = json['password'];
    gender = json['gender'];
    hometown = json['hometown'];
    permanentAddress = json['permanentAddress'];
    occupation = json['occupation'];
    classStudent = json['class'];
    if (json['students'] != null) {
      students = (json['students'] as List).map((studentJson) {
        return StudentData.fromJson(studentJson);
      }).toList();
    }
    contactPhone = json['contactPhone'];
    contactAddress = json['contactAddress'];
    educationLevel = json['educationLevel'];
    graduationCertificate = json['graduationCertificate'].cast<String>();
    academicPerformance = json['academicPerformance'];
    conduct = json['conduct'];
    classRanking10 = json['classRanking10'];
    classRanking11 = json['classRanking11'];
    classRanking12 = json['classRanking12'];
    graduationYear = json['graduationYear'];
    ethnicity = json['ethnicity'];
    religion = json['religion'];
    beneficiary = json['beneficiary'];
    area = json['area'];
    idCardIssuedDate = json['idCardIssuedDate'];
    idCardIssuedPlace = json['idCardIssuedPlace'];
    fatherFullName = json['fatherFullName'];
    motherFullName = json['motherFullName'];
    notes = json['notes'];
    isStudying = json['isStudying'];
    avatarUrl = json['avatarUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['studentId'] = studentId;
    data['gmail'] = gmail;
    data['phone'] = phone;
    data['fullName'] = fullName;
    data['birthDate'] = birthDate;
    data['cccd'] = cccd;
    data['birthPlace'] = birthPlace;
    data['customYear'] = customYear;
    data['mssv'] = mssv;
    data['password'] = password;
    data['gender'] = gender;
    data['hometown'] = hometown;
    data['permanentAddress'] = permanentAddress;
    data['occupation'] = occupation;
    data['class'] = classStudent;
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    data['contactPhone'] = contactPhone;
    data['contactAddress'] = contactAddress;
    data['educationLevel'] = educationLevel;
    data['graduationCertificate'] = graduationCertificate;
    data['academicPerformance'] = academicPerformance;
    data['conduct'] = conduct;
    data['classRanking10'] = classRanking10;
    data['classRanking11'] = classRanking11;
    data['classRanking12'] = classRanking12;
    data['graduationYear'] = graduationYear;
    data['ethnicity'] = ethnicity;
    data['religion'] = religion;
    data['beneficiary'] = beneficiary;
    data['area'] = area;
    data['idCardIssuedDate'] = idCardIssuedDate;
    data['idCardIssuedPlace'] = idCardIssuedPlace;
    data['fatherFullName'] = fatherFullName;
    data['motherFullName'] = motherFullName;
    data['notes'] = notes;
    data['isStudying'] = isStudying;
    data['avatarUrl'] = avatarUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
