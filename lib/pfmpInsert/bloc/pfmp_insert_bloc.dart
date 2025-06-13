import 'package:app_gestion_stage/class/pfmp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pfmp_insert_event.dart';
part 'pfmp_insert_state.dart';

class PfmpInsertBloc extends Bloc<PfmpInsertEvent, PfmpInsertState> {
  PfmpInsertBloc() : super(const PfmpInsertInitial()) {
    on<PfmpInsert_Submit>(_submit);
    on<PfmpInsert_GetInfos>(_getInfos);
    on<PfmpInsert_Update>(_onUpdate);
  }

  Pfmp? targetPfmp;

  // Controller pour les champs de saisies
  final tec_companyName = TextEditingController();
  final tec_address = TextEditingController();
  final tec_bossName = TextEditingController();
  final tec_tutorName = TextEditingController();
  final tec_tutorContact = TextEditingController();
  final tec_siretNumber = TextEditingController();
  final tec_phoneNumber = TextEditingController();
  final tec_mailAddress = TextEditingController();
  final tec_mainActivity = TextEditingController();

  final tec_secondaryActivity = TextEditingController();
  final tec_totalWorkforce = TextEditingController();
  final tec_serviceWorkforce = TextEditingController();
  bool sectorType = false;
  final tec_legalStatus = TextEditingController();
  int activitySector = 0;
  bool productDurableGoods = false;
  bool productSemiDurableGoods = false;
  bool productNonDurableGoods = false;
  bool productMerchantServices = false;
  bool productNonMerchantServices = false;

  // attribut d'une PFMP en vue de la stockée dans la base de données
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  void _onUpdate(PfmpInsert_Update event, Emitter<PfmpInsertState> emit) {
    emit(PfmpInsertInitialized());
  }

  void _submit(PfmpInsert_Submit event, Emitter<PfmpInsertState> emit) async {
    Pfmp newPFMP = Pfmp(
      idPfmp: targetPfmp != null ? targetPfmp!.idPfmp : "",
      companyName: event.companyName,
      address: event.address,
      bossName: event.bossName,
      tutorName: event.tutorName,
      tutorContact: event.tutorContact,
      siretNumber: event.siretNumber,
      phoneNumber: event.phoneNumber,
      mailAddress: event.mailAddress,
      mainActivity: event.mainActivity,

      secondaryActivity: event.secondaryActivity,
      totalWorkforce: event.totalWorkforce,
      serviceWorkforce: event.serviceWorkforce,
      sectorType: event.sectorType,
      legalStatus: event.legalStatus,
      activitySector: event.activitySector,
      productDurableGoods: event.productDurableGoods,
      productSemiDurableGoods: event.productSemiDurableGoods,
      productNonDurableGoods: event.productNonDurableGoods,
      productMerchantServices: event.productMerchantServices,
      productNonMerchantServices: event.productNonMerchantServices,

      startDate: event.startDate,
      endDate: event.endDate,
    );

    if (newPFMP.idPfmp == "") {
      newPFMP.create();
    } else {
      newPFMP.update();
    }

    Navigator.pop(event.context);
    emit(PfmpInsertInitial());
  }

  void _getInfos(
    PfmpInsert_GetInfos event,
    Emitter<PfmpInsertState> emit,
  ) async {
    if (event.pfmpId != null) {
      targetPfmp = await Pfmp.retrieve(event.pfmpId.toString());
    }

    if (targetPfmp != null) {
      tec_companyName.text = targetPfmp!.companyName;
      tec_address.text = targetPfmp!.address;
      tec_bossName.text = targetPfmp!.bossName;
      tec_tutorName.text = targetPfmp!.tutorName;
      tec_tutorContact.text = targetPfmp!.tutorContact;
      tec_siretNumber.text = targetPfmp!.siretNumber;
      tec_phoneNumber.text = targetPfmp!.phoneNumber;
      tec_mainActivity.text = targetPfmp!.mailAddress;
      tec_mainActivity.text = targetPfmp!.mainActivity;

      tec_secondaryActivity.text = targetPfmp!.secondaryActivity ?? "";
      tec_totalWorkforce.text = targetPfmp!.totalWorkforce.toString() ?? "";
      tec_serviceWorkforce.text = targetPfmp!.serviceWorkforce.toString() ?? "";
      sectorType = targetPfmp!.sectorType ?? false;
      tec_legalStatus.text = targetPfmp!.legalStatus ?? "";
      activitySector = targetPfmp!.activitySector ?? 0;
      productDurableGoods = targetPfmp!.productDurableGoods ?? false;
      productSemiDurableGoods = targetPfmp!.productSemiDurableGoods ?? false;
      productNonDurableGoods = targetPfmp!.productNonDurableGoods ?? false;
      productMerchantServices = targetPfmp!.productMerchantServices ?? false;
      productNonMerchantServices = targetPfmp!.productNonMerchantServices ?? false;

      startDate = targetPfmp!.startDate;
      endDate = targetPfmp!.endDate;
    }

    emit(PfmpInsertInitialized());
  }
}
