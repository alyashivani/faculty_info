// import 'package:faculty_info/models/faculty.dart';
import 'package:faculty_info/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference facultyCollection =
      FirebaseFirestore.instance.collection('Faculty');

  Future<void> updateUserData(
      String name,
      String gender,
      String email,
      int contactNumber,
      String contactAddress,
      String empid,
      String department,
      String designation,
      String joiningDate,
      String categoryEmp,
      String qualification,
      String yrQualification,
      String socialCategory,
      String subjectTeach,
      String avatarUrl,
      String phd,
      String researchInterest,
      String startingYear,
      String instName) async {
    return await facultyCollection.doc(uid).set({
      'name': name,
      'gender': gender,
      'email': email,
      'contactNumber': contactNumber,
      'contactAddress': contactAddress,
      'empid': empid,
      'department': department,
      'designation': designation,
      'joiningDate': joiningDate,
      'categoryEmp': categoryEmp,
      'qualification': qualification,
      'yrQualification': yrQualification,
      'socialCategory': socialCategory,
      'subjectTeach': subjectTeach,
      'avatarUrl': avatarUrl,
      'phd': phd,
      'researchInterest': researchInterest,
      'startingYear': startingYear,
      'instName': instName,
    });
  }

  // faculty list from snapshot
  List<UserData> _facultyListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return UserData(
          name: doc.data()['name'] ?? '',
          gender: doc.data()['gender'] ?? '',
          email: doc.data()['email'] ?? '',
          contactNumber: doc.data()['contactNumber'] ?? 0,
          contactAddress: doc.data()['contactAddress'] ?? '',
          empid: doc.data()['empid'] ?? '',
          department: doc.data()['department'] ?? '',
          designation: doc.data()['designation'] ?? '',
          joiningDate: doc.data()['joiningDate'] ?? '',
          categoryEmp: doc.data()['categoryEmp'] ?? '',
          qualification: doc.data()['qualification'] ?? '',
          yrQualification: doc.data()['yrQualification'] ?? '',
          socialCategory: doc.data()['socialCategory'] ?? '',
          subjectTeach: doc.data()['subjectTeach'] ?? '',
          avatarUrl: doc.data()['avatarUrl'] ?? '');
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()['name'],
        gender: snapshot.data()['gender'],
        email: snapshot.data()['email'],
        contactNumber: snapshot.data()['contactNumber'],
        contactAddress: snapshot.data()['contactAddress'],
        empid: snapshot.data()['empid'],
        department: snapshot.data()['department'],
        designation: snapshot.data()['designation'],
        joiningDate: snapshot.data()['joiningDate'],
        categoryEmp: snapshot.data()['categoryEmp'],
        qualification: snapshot.data()['qualification'],
        yrQualification: snapshot.data()['yrQualification'],
        socialCategory: snapshot.data()['socialCategory'],
        subjectTeach: snapshot.data()['subjectTeach'],
        avatarUrl: snapshot.data()['avatarUrl'],
        phd: snapshot.data()['phd'],
        researchInterest: snapshot.data()['researchInterest'],
        instName: snapshot.data()['instName'],
        startingYear: snapshot.data()['startingYear']);
  }

  // get faculties stream
  Stream<List<UserData>> get faculties {
    return facultyCollection.snapshots().map(_facultyListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return facultyCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
