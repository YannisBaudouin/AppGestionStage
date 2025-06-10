import 'appUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogDay {
  late String id;
  late String parentPfmpId;
  late DateTime date;
  late String content;

  LogDay(this.id, this.parentPfmpId, this.date, this.content);

  void create() async {
    AppUser user = await AppUser.retrieve(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference logDayListRef = FirebaseFirestore.instance
    .collection("users")
    .doc(user.uid)
    .collection('pfmp')
    .doc(parentPfmpId)
    .collection('LogBook');

    final data = {
      "date": DateTime(date.year, date.month, date.day) ,
      "content": content
    };

     DocumentReference logDayRef = await logDayListRef.add(data);
     id = logDayRef.id;
  }

  void update() async {
    AppUser user = await AppUser.retrieve(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference logDayListRef = FirebaseFirestore.instance
    .collection("users")
    .doc(user.uid)
    .collection('pfmp')
    .doc(parentPfmpId)
    .collection('LogBook');

    DocumentReference logDayRef = logDayListRef.doc(id);

   final data = {
      "date": DateTime(date.year, date.month, date.day),
      "content": content
    };

    logDayRef.set(data);
  }

  static Future<LogDay> retrieve(String logDayId, String pfmpId) async {
    AppUser user = await AppUser.retrieve(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference logDayListRef = FirebaseFirestore.instance
    .collection("users")
    .doc(user.uid)
    .collection('pfmp')
    .doc(pfmpId)
    .collection('LogBook');

    DocumentReference logDayRef = logDayListRef.doc(logDayId);

    final snapshot = await logDayRef.get();
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

    return LogDay(logDayId, pfmpId, userData["date"], userData["content"]);
  }

  static Future<LogDay?> retrieveFromDate(DateTime date, String pfmpId) async {
    AppUser user = await AppUser.retrieve(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference logDayListRef = FirebaseFirestore.instance
    .collection("users")
    .doc(user.uid)
    .collection('pfmp')
    .doc(pfmpId)
    .collection('LogBook');

    Query logDayQuery = logDayListRef.where("date", isEqualTo: DateTime(date.year, date.month, date.day));
    QuerySnapshot querySnapshot = await logDayQuery.get();

    if (querySnapshot.docs.isEmpty) {return null;}

    QueryDocumentSnapshot snapshot = querySnapshot.docs[0];
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return LogDay(snapshot.id, pfmpId, data["date"].toDate(), data["content"]);
  }
}