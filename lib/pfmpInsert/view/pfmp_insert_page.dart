import 'package:app_gestion_stage/class/pfmp.dart';
import 'package:app_gestion_stage/emploiDuTemps/view/pfmp_emploi_temps_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/pfmp_insert_bloc.dart';
import 'package:app_gestion_stage/global_var.dart' as global;
import 'package:app_gestion_stage/customWidget/custom_widget.dart';

class PfmpInsertPage extends StatelessWidget {
  final String? pfmpId;
  const PfmpInsertPage({super.key, this.pfmpId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PfmpInsertBloc(),
      child: PfmpInsertView(pfmpId: pfmpId),
    );
  }
}

class PfmpInsertView extends StatelessWidget {
  final String? pfmpId;
  const PfmpInsertView({super.key, this.pfmpId});

  //Page de création des PFMPs
  @override
  Widget build(BuildContext context) {
    //Booléen qui change par rapport au thème
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    //Définition des dates pour le calendrier
    DateTime lastDate = DateTime(
      DateTime.now().year + 50,
      DateTime.now().month,
      DateTime.now().day,
    );
    DateTime firstDate = DateTime(1980, 1, 1, 0, 0, 0, 0, 0);

    // date pour définir le début et la fin des dates sélectionner dans le calendrier
    DateTimeRange selectedDate = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    );

    return BlocBuilder<PfmpInsertBloc, PfmpInsertState>(
      buildWhen: (prev, state) => true, //prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        switch (state) {
          case PfmpInsertInitial():
            context.read<PfmpInsertBloc>().add(PfmpInsert_GetInfos(pfmpId));
          default:
        }

        Pfmp? targetPfmp = context.select(
          (PfmpInsertBloc bloc) => bloc.targetPfmp,
        );

        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //Utilise le booléen définit plus haut pour changer l'image
              global.currentLogo(isDarkMode),
              RichText(
                text: TextSpan(
                  text: targetPfmp != null ? 'Edition PFMP' : 'Nouvelle PFMP',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width - 50,
                height: 600,
                //utiliser pour customiser un Container
                decoration: BoxDecoration(
                  //backgroundcolors
                  color: Color(global.darkThemeSeco + 80),
                  //permet d'arondir le container
                  borderRadius: BorderRadius.circular(12),
                ),
                //contient le formulaire pour créer une nouvelle PFMP
                child: ListView(
                  padding: EdgeInsets.only(bottom: 50),
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: "Société",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),

                    CustomTF(
                      labelText: "Nom*",
                      controller: context.read<PfmpInsertBloc>().tec_companyName,
                      context: context,
                    ),
                    CustomTF(
                      labelText: "Adresse*",
                      controller: context.read<PfmpInsertBloc>().tec_address,
                      context: context,
                    ),
                    CustomTF(
                      labelText: "Nom du dirigeant*",
                      controller: context.read<PfmpInsertBloc>().tec_bossName,
                      context: context,
                    ),
                    CustomTF(
                      labelText: "Nom du tuteur*",
                      controller: context.read<PfmpInsertBloc>().tec_tutorName,
                      context: context,
                    ),
                    CustomTF(
                      labelText: "Contact du tuteur*",
                      controller: context.read<PfmpInsertBloc>().tec_tutorContact,
                      context: context,
                    ),
                    CustomTF(
                      labelText: "N° de Siret*",
                      controller: context.read<PfmpInsertBloc>().tec_siretNumber,
                      context: context,
                    ),
                    CustomTF(
                      labelText: "Numéro de téléphone*",
                      controller: context.read<PfmpInsertBloc>().tec_phoneNumber,
                      context: context,
                    ),
                    CustomTF(
                      labelText: "Adresse Mail*",
                      controller: context.read<PfmpInsertBloc>().tec_mailAddress,
                      context: context,
                    ),
                    CustomTF(
                      labelText: "Activité principale*",
                      controller: context.read<PfmpInsertBloc>().tec_mainActivity,
                      context: context,
                    ),

                    CustomTF(
                      labelText: "Activité secondaire",
                      controller: context.read<PfmpInsertBloc>().tec_secondaryActivity,
                      context: context,
                    ),
                    CustomTF(
                      labelText: "Effectif total",
                      controller: context.read<PfmpInsertBloc>().tec_totalWorkforce,
                      context: context,
                    ),
                    CustomTF(
                      labelText: "Effectif du service",
                      controller: context.read<PfmpInsertBloc>().tec_serviceWorkforce,
                      context: context,
                    ),
                    // sectorType
                    Row(
                      children: [
                        CustomRT(
                          text: "Secteur : ",
                          style: Theme.of(context).textTheme.titleLarge,
                          context: context,
                        ),
                        CustomCheckboxLabel(
                          labelText: "Public",
                          value: context.read<PfmpInsertBloc>().sectorType,
                          onChanged: (bool? value) {
                            context.read<PfmpInsertBloc>().sectorType = !context.read<PfmpInsertBloc>().sectorType;
                            context.read<PfmpInsertBloc>().add(
                              PfmpInsert_Update(),
                            );
                          },
                        ),
                        CustomCheckboxLabel(
                          labelText: "Privé",
                          value: !context.read<PfmpInsertBloc>().sectorType,
                          onChanged: (bool? value) {
                            context.read<PfmpInsertBloc>().sectorType = !context.read<PfmpInsertBloc>().sectorType;
                            context.read<PfmpInsertBloc>().add(
                              PfmpInsert_Update(),
                            );
                          },
                        ),
                      ],
                    ),
                    CustomTF(
                      labelText: "Forme juridique",
                      controller: context.read<PfmpInsertBloc>().tec_legalStatus,
                      context: context,
                    ),

                    CustomRT(
                      text: "Secteur d'activité : ",
                      style: Theme.of(context).textTheme.titleLarge,
                      context: context,
                    ),
                    CustomCheckboxLabel(
                      labelText: "Primaire",
                      value: context.read<PfmpInsertBloc>().activitySector == 1,
                      onChanged: (bool? value) {
                        context.read<PfmpInsertBloc>().activitySector = value == true ? 1 : 0;
                        context.read<PfmpInsertBloc>().add(PfmpInsert_Update());
                      },
                    ),
                    CustomCheckboxLabel(
                      labelText: "Secondaire",
                      value: context.read<PfmpInsertBloc>().activitySector == 2,
                      onChanged: (bool? value) {
                        context.read<PfmpInsertBloc>().activitySector = value == true ? 2 : 0;
                        context.read<PfmpInsertBloc>().add(PfmpInsert_Update());
                      },
                    ),
                    CustomCheckboxLabel(
                      labelText: "Tertiaire",
                      value: context.read<PfmpInsertBloc>().activitySector == 3,
                      onChanged: (bool? value) {
                        context.read<PfmpInsertBloc>().activitySector = value == true ? 3 : 0;
                        context.read<PfmpInsertBloc>().add(PfmpInsert_Update());
                      },
                    ),

                    CustomRT(
                      text: "Production",
                      style: Theme.of(context).textTheme.displayMedium,
                      context: context,
                    ),
                    Column(
                      children: [
                        CustomCheckboxLabel(
                          labelText: "De biens",
                          value:
                              (context.read<PfmpInsertBloc>().productDurableGoods == true ||
                              context.read<PfmpInsertBloc>().productSemiDurableGoods == true ||
                              context.read<PfmpInsertBloc>().productNonDurableGoods == true),
                          onChanged: (bool? value) {
                            context.read<PfmpInsertBloc>().productDurableGoods = false;
                            context.read<PfmpInsertBloc>().productSemiDurableGoods = false;
                            context.read<PfmpInsertBloc>().productNonDurableGoods = false;
                            context.read<PfmpInsertBloc>().add(
                              PfmpInsert_Update(),
                            );
                          },
                        ),
                        Row(
                          children: [
                            CustomCheckboxLabel(
                              labelText: "Durables",
                              value: context.read<PfmpInsertBloc>().productDurableGoods,
                              onChanged: (bool? value) {
                                context.read<PfmpInsertBloc>().productDurableGoods = value ?? false;
                                context.read<PfmpInsertBloc>().add(
                                  PfmpInsert_Update(),
                                );
                              },
                            ),
                            CustomCheckboxLabel(
                              labelText: "Semi durables",
                              value: context.read<PfmpInsertBloc>().productSemiDurableGoods,
                              onChanged: (bool? value) {
                                context.read<PfmpInsertBloc>().productSemiDurableGoods = value ?? false;
                                context.read<PfmpInsertBloc>().add(
                                  PfmpInsert_Update(),
                                );
                              },
                            ),
                            CustomCheckboxLabel(
                              labelText: "Non durables",
                              value: context.read<PfmpInsertBloc>().productNonDurableGoods,
                              onChanged: (bool? value) {
                                context.read<PfmpInsertBloc>().productNonDurableGoods = value ?? false;
                                context.read<PfmpInsertBloc>().add(
                                  PfmpInsert_Update(),
                                );
                              },
                            ),
                          ],
                        ),
                        CustomCheckboxLabel(
                          labelText: "De services",
                          value:
                              (context.read<PfmpInsertBloc>().productMerchantServices == true ||
                              context.read<PfmpInsertBloc>().productNonMerchantServices == true),
                          onChanged: (bool? value) {
                            context.read<PfmpInsertBloc>().productMerchantServices = false;
                            context.read<PfmpInsertBloc>().productNonMerchantServices = false;
                            context.read<PfmpInsertBloc>().add(
                              PfmpInsert_Update(),
                            );
                          },
                        ),
                        Row(
                          children: [
                            CustomCheckboxLabel(
                              labelText: "Marchands",
                              value: context.read<PfmpInsertBloc>().productMerchantServices,
                              onChanged: (bool? value) {
                                context.read<PfmpInsertBloc>().productMerchantServices = value ?? false;
                                context.read<PfmpInsertBloc>().add(
                                  PfmpInsert_Update(),
                                );
                              },
                            ),
                            CustomCheckboxLabel(
                              labelText: "Non marchands",
                              value: context.read<PfmpInsertBloc>().productNonMerchantServices,
                              onChanged: (bool? value) {
                                context.read<PfmpInsertBloc>().productNonMerchantServices = value ?? false;
                                context.read<PfmpInsertBloc>().add(
                                  PfmpInsert_Update(),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    Container(
                      height: 200,
                      margin: EdgeInsets.only(bottom: 20),
                      child: CustomEB(
                        text: "Sélectionner la date",
                        pressed: () async {
                          final DateTimeRange?
                          dateTimeRange = await showDateRangePicker(
                            //le calendrier
                            context: context,
                            firstDate:
                                firstDate, //première date sélectionnable(la plus loin dans le temps)
                            lastDate:
                                lastDate, //dernière date sélectionnable(la plus près dans le temps)
                            initialDateRange: DateTimeRange(
                              start: context.read<PfmpInsertBloc>().startDate,
                              end: context.read<PfmpInsertBloc>().endDate,
                            ),
                            saveText:
                                "Enregistrer", //pour modifier l'affichage du boutton qui permet d'enregistrer les dates
                          );
                          if (dateTimeRange != null) {
                            selectedDate = dateTimeRange;
                            context.read<PfmpInsertBloc>().startDate = selectedDate
                                .start; //affectation de la valeur de début à une varible instancié avant
                            context.read<PfmpInsertBloc>().endDate = selectedDate
                                .end; //affectation de la valeur de début à une varible instancié avant
                          }
                        },
                        context: context,
                      ),
                    ),
                    CustomEB(
                      text: "Emploi du temps",
                      pressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PfmpEmploiTempsPage(pfmpId: pfmpId),
                          ),
                        );
                      },
                      context: context,
                    ),
                    Text(
                      "Nombre de semaines : ${(DateTime(context.read<PfmpInsertBloc>().startDate.year - context.read<PfmpInsertBloc>().endDate.year, context.read<PfmpInsertBloc>().startDate.month - context.read<PfmpInsertBloc>().endDate.month, context.read<PfmpInsertBloc>().startDate.day - context.read<PfmpInsertBloc>().endDate.day).day / 7 + 0.5).round()}",
                    ),
                    CustomEB(
                      text: "Terminer",
                      pressed: () => context.read<PfmpInsertBloc>().add(
                        PfmpInsert_Submit(
                          context: context,
                          companyName: context.read<PfmpInsertBloc>().tec_companyName.text,
                          address: context.read<PfmpInsertBloc>().tec_address.text,
                          bossName: context.read<PfmpInsertBloc>().tec_bossName.text,
                          tutorName: context.read<PfmpInsertBloc>().tec_tutorName.text,
                          tutorContact: context.read<PfmpInsertBloc>().tec_tutorContact.text,
                          siretNumber: context.read<PfmpInsertBloc>().tec_siretNumber.text,
                          phoneNumber: context.read<PfmpInsertBloc>().tec_phoneNumber.text,
                          mailAddress: context.read<PfmpInsertBloc>().tec_mailAddress.text,
                          mainActivity: context.read<PfmpInsertBloc>().tec_mainActivity.text,

                          secondaryActivity: context.read<PfmpInsertBloc>().tec_secondaryActivity.text,
                          totalWorkforce: int.tryParse(context.read<PfmpInsertBloc>().tec_totalWorkforce.text) ?? 0,
                          serviceWorkforce: int.tryParse(context.read<PfmpInsertBloc>().tec_serviceWorkforce.text) ?? 0,
                          sectorType: context.read<PfmpInsertBloc>().sectorType,
                          legalStatus: context.read<PfmpInsertBloc>().tec_legalStatus.text,
                          activitySector: context.read<PfmpInsertBloc>().activitySector,
                          productDurableGoods: context.read<PfmpInsertBloc>().productDurableGoods,
                          productSemiDurableGoods: context.read<PfmpInsertBloc>().productSemiDurableGoods,
                          productNonDurableGoods: context.read<PfmpInsertBloc>().productNonDurableGoods,
                          productMerchantServices: context.read<PfmpInsertBloc>().productMerchantServices,
                          productNonMerchantServices: context.read<PfmpInsertBloc>().productNonMerchantServices,

                          startDate: context.read<PfmpInsertBloc>().startDate,
                          endDate: context.read<PfmpInsertBloc>().endDate,
                        ),
                      ),
                      context: context,
                    ),
                    CustomREB(text: "Retour", context: context),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
