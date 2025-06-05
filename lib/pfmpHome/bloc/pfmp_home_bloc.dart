import 'package:app_gestion_stage/class/appUser.dart';
import 'package:app_gestion_stage/class/pfmp.dart';
import 'package:app_gestion_stage/pfmpInsert/pfmp_insert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pfmp_home_event.dart';
part 'pfmp_home_state.dart';

class PfmpHomeBloc extends Bloc<PfmpHomeEvent, PfmpHomeState> {
  PfmpHomeBloc() : super(const PfmpHomeInitial()) {
    on<PfmpHome_GetListWidgets>(_getListWidgets);
  }

  List<Widget> widgetsListPfmps = <Widget>[];

  void _getListWidgets(
    PfmpHome_GetListWidgets event,
    Emitter<PfmpHomeState> emit,
  ) async {
    widgetsListPfmps = <Widget>[];

    AppUser user = await AppUser.retrieve(
      FirebaseAuth.instance.currentUser!.uid,
    );
    DocumentReference userRef = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid);
    CollectionReference pfmpListRef = userRef.collection('pfmp');

    QuerySnapshot snapshot = await pfmpListRef.get();
    List<QueryDocumentSnapshot> pfmpList = snapshot.docs.map((doc) => doc).toList();

    pfmpList.forEach((QueryDocumentSnapshot pfmpObj) {
      dynamic pfmpData = pfmpObj.data();
      Pfmp pfmp = Pfmp(
        pfmpObj.id,
        pfmpData["nomSociete"],
        pfmpData["nomSociete"],
        pfmpData["statusSociete"],
        pfmpData["nomFormateur"],
        pfmpData["contactFormateur"],
        pfmpData['dateDebut'].toDate(),
        pfmpData['dateFin'].toDate(),
      );

      widgetsListPfmps.add(
        ElevatedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pfmp.nomSociete,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                pfmp.dateDebut.toString().split(' ')[0].replaceAll("-", "/") +
                    "-" +
                    pfmp.dateFin.toString().split(' ')[0].replaceAll("-", "/"),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          onPressed: () async {
            await Navigator.push(
              event.context,
              MaterialPageRoute(builder: (context) => PfmpInsertPage(pfmpId: pfmp.idPfmp)),
            );

            event.context.read<PfmpHomeBloc>().add(PfmpHome_GetListWidgets(context: event.context));
          },
        ),
      );
    });

    emit(PfmpHomeInitialized());
  }
}
