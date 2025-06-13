import 'package:app_gestion_stage/class/appUser.dart';
import 'package:app_gestion_stage/class/pfmp.dart';
import 'package:app_gestion_stage/pfmpProfil/pfmp_profil.dart';
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

  ListView listViewPfmp = ListView();

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
    List<QueryDocumentSnapshot> pfmpList = snapshot.docs
        .map((doc) => doc)
        .toList();

    for (final QueryDocumentSnapshot pfmpObj in pfmpList) {
      Pfmp pfmp = await Pfmp.retrieve(pfmpObj.id);

      widgetsListPfmps.add(
        ElevatedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pfmp.companyName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${pfmp.startDate.toString().split(' ')[0].replaceAll("-", "/")}-${pfmp.startDate.toString().split(' ')[0].replaceAll("-", "/")}",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          onPressed: () async {
            await Navigator.push(
              event.context,
              MaterialPageRoute(
                builder: (context) => PfmpProfilPage(pfmpId: pfmp.idPfmp),
              ),
            );

            event.context.read<PfmpHomeBloc>().add(
              PfmpHome_GetListWidgets(context: event.context),
            );
          },
        ),
      );
    }

    listViewPfmp = ListView(children: widgetsListPfmps);

    emit(PfmpHomeInitialized());
  }
}
