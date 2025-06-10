import 'appUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Pfmp {
  //attribut de la classe PFMP
  late String idPfmp;
  late String nomSociete;
  late String adresseSociete;
  late String statusSociete;
  late String nomFormateur;
  late String contactFormateur;
  late DateTime dateDebut;
  late DateTime dateFin;

  //Constructeur de la classe
  Pfmp(
    String idPfmp_,
    String nomSoc,
    String adresseSoc,
    String statusSoc,
    String nomForma,
    String contactForma,
    DateTime dateD,
    DateTime dateF,

  ) {
    idPfmp = idPfmp_;
    nomSociete = nomSoc;
    adresseSociete = adresseSoc;
    statusSociete = statusSoc;
    nomFormateur = nomForma;
    contactFormateur = contactForma;
    dateDebut = dateD;
    dateFin = dateF;
  }

  void create() async {
     AppUser user = await AppUser.retrieve(FirebaseAuth.instance.currentUser!.uid);
     DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(user.uid);

     CollectionReference pfmpListRef = userRef.collection('pfmp');

    final pfmpData = {
      "nomSociete": nomSociete,
      "adresseSociete": adresseSociete,
      "statusSociete": statusSociete,
      "nomFormateur": nomFormateur,
      "contactFormateur": contactFormateur,
      "dateDebut": dateDebut,
      "dateFin": dateFin,
    };

     DocumentReference pfmpRef = await pfmpListRef.add(pfmpData);

     idPfmp = pfmpRef.id;
  }

  void update() async {
     AppUser user = await AppUser.retrieve(FirebaseAuth.instance.currentUser!.uid);
     DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(user.uid);

     CollectionReference pfmpListRef = userRef.collection('pfmp');

    final pfmpData = {
      "nomSociete": nomSociete,
      "adresseSociete": adresseSociete,
      "statusSociete": statusSociete,
      "nomFormateur": nomFormateur,
      "contactFormateur": contactFormateur,
      "dateDebut": dateDebut,
      "dateFin": dateFin,
    };

     pfmpListRef.doc(idPfmp).set(pfmpData);
  }

  static Future<Pfmp> retrieve(String pfmpId) async {
    AppUser user = await AppUser.retrieve(FirebaseAuth.instance.currentUser!.uid);
     DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(user.uid);

    CollectionReference pfmpListRef = userRef.collection('pfmp');

    final snapshot = await pfmpListRef.doc(pfmpId).get();
    Map<String, dynamic> pfmpData = snapshot.data() as Map<String, dynamic>;

    return Pfmp(pfmpId, pfmpData["nomSociete"], pfmpData["adresseSociete"], pfmpData["statusSociete"], pfmpData["nomFormateur"], pfmpData["contactFormateur"], pfmpData["dateDebut"].toDate(), pfmpData["dateFin"].toDate());
  }
}
