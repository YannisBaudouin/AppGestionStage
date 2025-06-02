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
    this.idPfmp = idPfmp_;
    this.nomSociete = nomSoc;
    this.adresseSociete = adresseSoc;
    this.statusSociete = statusSoc;
    this.nomFormateur = nomForma;
    this.contactFormateur = contactForma;
    this.dateDebut = dateD;
    this.dateFin = dateF;
  }

  void create() async {
     AppUser user = await AppUser.retrieve(FirebaseAuth.instance.currentUser!.uid);
     DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(user.uid);

     CollectionReference pfmpListRef = userRef.collection('pfmp');

    final userData = {
      "nomSociete": this.nomSociete,
      "adresseSociete": this.adresseSociete,
      "statusSociete": this.statusSociete,
      "nomFormateur": this.nomFormateur,
      "contactFormateur": this.contactFormateur,
      "dateDebut": this.dateDebut,
      "dateFin": this.dateFin,
    };

     DocumentReference pfmpRef = await pfmpListRef.add(userData);

     this.idPfmp = pfmpRef.id;
  }

  void update() async {
     AppUser user = await AppUser.retrieve(FirebaseAuth.instance.currentUser!.uid);
     DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(user.uid);

     CollectionReference pfmpListRef = userRef.collection('pfmp');

     pfmpListRef.doc(this.idPfmp).set(this);
  }
}
