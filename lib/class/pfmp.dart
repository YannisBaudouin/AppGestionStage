import 'appUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Pfmp {
  //Attributs de la classe PFMP
  String idPfmp;
  String companyName;
  String address;
  String bossName;
  String tutorName;
  String tutorContact;
  String siretNumber;
  String phoneNumber;
  String mailAddress;
  String mainActivity;

  String? secondaryActivity;
  int? totalWorkforce;
  int? serviceWorkforce;
  bool? sectorType; // false = Secteur Privé, true = Secteur publique
  String? legalStatus;
  int? activitySector; // 0 = Primaire, 1 = Secondaire, 2 = Tertiaire
  bool? productDurableGoods;
  bool? productSemiDurableGoods;
  bool? productNonDurableGoods;
  bool? productMerchantServices;
  bool? productNonMerchantServices;

  bool? hasCDI;
  bool? hasCDD;
  bool? hasInterim;

  bool? hasApprenticeContract;
  String? requiredDiploma;

  String? typicalCustomerProfile;
  String? competition;

  String? companyValues;
  String? socialResponsibilities;

  DateTime startDate;
  DateTime endDate;

  //Constructeur de la classe
  Pfmp({
    required this.idPfmp,
    required this.companyName,
    required this.address,
    required this.bossName,
    required this.tutorName,
    required this.tutorContact,
    required this.siretNumber,
    required this.phoneNumber,
    required this.mailAddress,
    required this.mainActivity,

    this.secondaryActivity,
    this.totalWorkforce,
    this.serviceWorkforce,
    this.sectorType,
    this.legalStatus,
    this.activitySector,
    this.productDurableGoods,
    this.productSemiDurableGoods,
    this.productNonDurableGoods,
    this.productMerchantServices,
    this.productNonMerchantServices,

    required this.startDate,
    required this.endDate,
  });

  void create() async {
    AppUser user = await AppUser.retrieve(
      FirebaseAuth.instance.currentUser!.uid,
    );
    DocumentReference userRef = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid);

    CollectionReference pfmpListRef = userRef.collection('pfmp');

    final pfmpData = {
      "companyName": companyName,
      "address": address,
      "bossName": bossName,
      "tutorName": tutorName,
      "tutorContact": tutorContact,
      "siretNumber": siretNumber,
      "phoneNumber": phoneNumber,
      "mailAddress": mailAddress,
      "mainActivity": mainActivity,

      "secondaryActivity": secondaryActivity,
      "totalWorkforce": totalWorkforce,
      "serviceWorkforce": serviceWorkforce,
      "sectorType": sectorType,
      "legalStatus": legalStatus,
      "activitySector": activitySector,
      "productDurableGoods": productDurableGoods,
      "productSemiDurableGoods": productSemiDurableGoods,
      "productNonDurableGoods": productNonDurableGoods,
      "productMerchantServices": productMerchantServices,
      "productNonMerchantServices": productNonMerchantServices,

      "startDate": startDate,
      "endDate": endDate,
    };

    DocumentReference pfmpRef = await pfmpListRef.add(pfmpData);

    idPfmp = pfmpRef.id;
  }

  void update() async {
    AppUser user = await AppUser.retrieve(
      FirebaseAuth.instance.currentUser!.uid,
    );
    DocumentReference userRef = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid);

    CollectionReference pfmpListRef = userRef.collection('pfmp');

    final pfmpData = {
      "companyName": companyName,
      "address": address,
      "bossName": bossName,
      "tutorName": tutorName,
      "tutorContact": tutorContact,
      "siretNumber": siretNumber,
      "phoneNumber": phoneNumber,
      "mailAddress": mailAddress,
      "mainActivity": mainActivity,

      "secondaryActivity": secondaryActivity,
      "totalWorkforce": totalWorkforce,
      "serviceWorkforce": serviceWorkforce,
      "sectorType": sectorType,
      "legalStatus": legalStatus,
      "activitySector": activitySector,
      "productDurableGoods": productDurableGoods,
      "productSemiDurableGoods": productSemiDurableGoods,
      "productNonDurableGoods": productNonDurableGoods,
      "productMerchantServices": productMerchantServices,
      "productNonMerchantServices": productNonMerchantServices,

      "startDate": startDate,
      "endDate": endDate,
    };

    pfmpListRef.doc(idPfmp).set(pfmpData);
  }

  static Future<Pfmp> retrieve(String pfmpId) async {
    AppUser user = await AppUser.retrieve(
      FirebaseAuth.instance.currentUser!.uid,
    );
    DocumentReference userRef = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid);

    CollectionReference pfmpListRef = userRef.collection('pfmp');

    final snapshot = await pfmpListRef.doc(pfmpId).get();
    Map<String, dynamic> pfmpData = snapshot.data() as Map<String, dynamic>;

    return Pfmp(
      idPfmp: pfmpId,
      companyName: pfmpData["companyName"],
      address: pfmpData["address"],
      bossName: pfmpData["bossName"],
      tutorName: pfmpData["tutorName"],
      tutorContact: pfmpData["tutorContact"],
      siretNumber: pfmpData["siretNumber"],
      phoneNumber: pfmpData["phoneNumber"],
      mailAddress: pfmpData["mailAddress"],
      mainActivity: pfmpData["mainActivity"],

      secondaryActivity: pfmpData["secondaryActivity"],
      totalWorkforce: pfmpData["totalWorkforce"],
      serviceWorkforce: pfmpData["serviceWorkforce"],
      sectorType: pfmpData["sectorType"],
      legalStatus: pfmpData["legalStatus"],
      activitySector: pfmpData["activitySector"],
      productDurableGoods: pfmpData["productDurableGoods"],
      productSemiDurableGoods: pfmpData["productSemiDurableGoods"],
      productNonDurableGoods: pfmpData["productNonDurableGoods"],
      productMerchantServices: pfmpData["productMerchantServices"],
      productNonMerchantServices: pfmpData["productNonMerchantServices"],

      startDate: pfmpData["startDate"].toDate(),
      endDate: pfmpData["endDate"].toDate(),
    );
  }
}
