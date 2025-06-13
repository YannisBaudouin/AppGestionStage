part of 'pfmp_insert_bloc.dart';

sealed class PfmpInsertEvent {
  const PfmpInsertEvent();
}

class PfmpInsert_GetInfos extends PfmpInsertEvent {
  final String? pfmpId;
  const PfmpInsert_GetInfos(this.pfmpId);
}

class PfmpInsert_Update extends PfmpInsertEvent {
  const PfmpInsert_Update();
}

class PfmpInsert_Submit extends PfmpInsertEvent {
  final String companyName;
  final String address;
  final String bossName;
  final String tutorName;
  final String tutorContact;
  final String siretNumber;
  final String phoneNumber;
  final String mailAddress;
  final String mainActivity;

  final String? secondaryActivity;
  final int? totalWorkforce;
  final int? serviceWorkforce;
  final bool? sectorType; // false = Secteur Privé, true = Secteur publique
  final String? legalStatus;
  final int? activitySector; // 0 = Rien, 1 = Primaire, 2 = Secondaire, 3 = Tertiaire
  final bool? productDurableGoods;
  final bool? productSemiDurableGoods;
  final bool? productNonDurableGoods;
  final bool? productMerchantServices;
  final bool? productNonMerchantServices;

  final DateTime startDate;
  final DateTime endDate;
  
  final BuildContext context;

  const PfmpInsert_Submit({
    required this.context,
    required this.companyName,
    required this.address,
    required this.bossName,
    required this.tutorName,
    required this.tutorContact,
    required this.siretNumber,
    required this.phoneNumber,
    required this.mailAddress,
    required this.mainActivity,

    required this.secondaryActivity,
    required this.totalWorkforce,
    required this.serviceWorkforce,
    required this.sectorType,
    required this.legalStatus,
    required this.activitySector,
    required this.productDurableGoods,
    required this.productSemiDurableGoods,
    required this.productNonDurableGoods,
    required this.productMerchantServices,
    required this.productNonMerchantServices,

    required this.startDate,
    required this.endDate,
  });
}
