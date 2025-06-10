import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pfmp.dart';

class AppUser {
  late String uid;
  late String? email;

  late String firstName;
  late String lastName;
  late DateTime birthDate;
  late String status;

  late String school;
  late String userClass;
  late String sector;

  late List<Pfmp> pfmpList;
  
  /*
  AppUser({
    required this.uid, 
    required this.email, 
    required this.firstName, 
    required this.lastName, 
    required this.birthDate,
    required this.status,
    required this.school,
    required this.userClass,
    required this.sector}); */

  AppUser(
    String uid_,
    String? email_,
    String firstName_,
    String lastName_,
    DateTime birthDate_,
    String status_,
    String school_,
    String userClass_,
    String sector_,
    List<Pfmp> pfmpList_
  ) {
    uid = uid_;
    email = email_;
    firstName = firstName_;
    lastName = lastName_;
    birthDate = birthDate_;
    status = status_;
    school = school_;
    userClass = userClass_;
    sector = sector_;
    pfmpList = pfmpList_;
  }

  void update() {
    DocumentReference statusRef = FirebaseFirestore.instance.collection('Statut').doc(status.isEmpty ? "None" : status);
    DocumentReference schoolRef = FirebaseFirestore.instance.collection('Etablissement').doc(school.isEmpty ? "None" : school);
    DocumentReference userClassRef = FirebaseFirestore.instance.collection('Classe').doc(userClass.isEmpty ? "None" : userClass);
    DocumentReference sectorRef = FirebaseFirestore.instance.collection('Filliere').doc(sector.isEmpty ? "None" : sector);

    DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(uid);

    final userData = {
      "firstName": firstName,
      "lastName": lastName,
      "birthDate": birthDate,
      "status": statusRef,

      "school": schoolRef,
      "class": userClassRef,
      "sector": sectorRef
    };

    userRef.set(userData);
  }

  static Future<AppUser> retrieve(String idToSearch) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    final snapshot = await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

    return AppUser(idToSearch, FirebaseAuth.instance.currentUser!.email, userData['firstName'], userData['lastName'], userData['birthDate'].toDate(), userData['status'].id, userData['school'].id, userData['class'].id, userData['sector'].id, []);
  }

  void delete() {

  }
}
