class Users {
  final String uid;

  Users({this.uid});
}

class UserData {
  final String uid;
  final String name, gender, email, contactAddress;
  final int contactNumber;
  final String empid;
  final String department,
      designation,
      qualification,
      categoryEmp,
      socialCategory;
  final String yrQualification, joiningDate;
  final String subjectTeach;
  String avatarUrl;
  final String phd, researchInterest, startingYear, instName;

  UserData(
      {this.uid,
      this.avatarUrl,
      this.name,
      this.gender,
      this.email,
      this.contactNumber,
      this.contactAddress,
      this.empid,
      this.department,
      this.designation,
      this.joiningDate,
      this.categoryEmp,
      this.qualification,
      this.yrQualification,
      this.socialCategory,
      this.subjectTeach,
      this.phd,
      this.researchInterest,
      this.instName,
      this.startingYear});
}
