import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  late String uid;
  late String firstName;
  late String lastName;
  late DateTime birthDate;
  late String status;

  late String school;
  late String userClass;
  late String sector;
  
  AppUser(
    String uid_,
    String firstName_,
    String lastName_,
    DateTime birthDate_,
    String status_,
    String school_,
    String userClass_,
    String sector_,    
  ) {
    this.uid = uid_;
    this.firstName = firstName_;
    this.lastName = lastName_;
    this.birthDate = birthDate_;
    this.status = status_;
    this.school = school_;
    this.userClass = userClass_;
    this.sector = sector_;
  }

  void update() {
    DocumentReference statusRef = FirebaseFirestore.instance.collection('Statut').doc(this.status.isEmpty ? "None" : this.status);
    DocumentReference schoolRef = FirebaseFirestore.instance.collection('Etablissement').doc(this.school.isEmpty ? "None" : this.school);
    DocumentReference userClassRef = FirebaseFirestore.instance.collection('Classe').doc(this.userClass.isEmpty ? "None" : this.userClass);
    DocumentReference sectorRef = FirebaseFirestore.instance.collection('Filliere').doc(this.sector.isEmpty ? "None" : this.sector);

    final userData = {
      "firstName": this.firstName,
      "lastName": this.lastName,
      "birthDate": this.birthDate,
      "status": statusRef,

      "school": schoolRef,
      "class": userClassRef,
      "sector": sectorRef
    };

    FirebaseFirestore.instance.collection("users").doc(this.uid).set(userData);
  }

  static Future<AppUser> retrieve(String idToSearch) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    final snapshot = await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

    return AppUser(idToSearch, userData['firstName'], userData['lastName'], userData['birthDate'].toDate(), userData['status'].id, userData['school'].id, userData['class'].id, userData['sector'].id);
  }

  void delete() {

  }
}
