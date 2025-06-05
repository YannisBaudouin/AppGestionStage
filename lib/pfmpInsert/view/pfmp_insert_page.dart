import 'package:app_gestion_stage/class/pfmp.dart';
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
      child: PfmpInsertView(pfmpId: pfmpId,),
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

    // attribut d'une PFMP en vue de la stockée dans la base de données
    DateTime dateDeb = DateTime.now();
    DateTime dateFin = DateTime.now();

    // date pour définir le début et la fin des dates sélectionner dans le calendrier
    DateTimeRange selectedDate = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    );

    // Controller pour les champs de saisies
    final nomSociete = TextEditingController();
    final adresseSoc = TextEditingController();
    final statusJuri = TextEditingController();
    final nomFormate = TextEditingController();
    final contactFor = TextEditingController();

    return BlocBuilder<PfmpInsertBloc, PfmpInsertState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        switch (state) {
          case PfmpInsertInitial():
           context.read<PfmpInsertBloc>().add(PfmpInsert_GetInfos(pfmpId));
          default:
        }

        Pfmp? targetPfmp = context.select((PfmpInsertBloc bloc) => bloc.targetPfmp);

        if (targetPfmp != null) {
          nomSociete.text = targetPfmp.nomSociete;
          adresseSoc.text = targetPfmp.adresseSociete;
          statusJuri.text = targetPfmp.statusSociete;
          nomFormate.text = targetPfmp.nomFormateur;
          contactFor.text = targetPfmp.contactFormateur;

          dateDeb = targetPfmp.dateDebut;
          dateFin = targetPfmp.dateFin;
        }

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
                height: 300,
                //utiliser pour customiser un Container
                decoration: BoxDecoration(
                  //backgroundcolors
                  color: Color(global.darkThemeSeco),
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
                      labelText: "Nom",
                      controller: nomSociete,
                      context: context,
                      hintText: "",
                      helperText: null,
                      cacher: false,
                    ),
                    CustomTF(
                      labelText: "Adresse",
                      controller: adresseSoc,
                      context: context,
                      hintText: "",
                      helperText: null,
                      cacher: false,
                    ),
                    CustomTF(
                      labelText: "Statut juridique",
                      controller: statusJuri,
                      context: context,
                      hintText: "",
                      helperText: null,
                      cacher: false,
                    ),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: "Formateur",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    CustomTF(
                      labelText: "Nom du formateur",
                      controller: nomFormate,
                      context: context,
                      hintText: "",
                      helperText: null,
                      cacher: false,
                    ),
                    CustomTF(
                      labelText: "Contact du formateur",
                      controller: contactFor,
                      context: context,
                      hintText: "",
                      helperText: null,
                      cacher: false,
                    ),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: "Période",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
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
                            initialDateRange: DateTimeRange(start: dateDeb, end: dateFin),
                            saveText:
                                "Enregistrer", //pour modifier l'affichage du boutton qui permet d'enregistrer les dates
                          );
                          if (dateTimeRange != null) {
                            selectedDate = dateTimeRange;
                            dateDeb = selectedDate
                                .start; //affectation de la valeur de début à une varible instancié avant
                            dateFin = selectedDate
                                .end; //affectation de la valeur de début à une varible instancié avant
                          }
                        },
                        context: context,
                      ),
                    ),
                    Text("Nombre de semaines : ${ (DateTime(dateDeb.year-dateFin.year, dateDeb.month-dateFin.month, dateDeb.day-dateFin.day).day/7 +0.5).round() }"),
                    CustomEB(
                      text: "Terminer",
                      pressed: () => context.read<PfmpInsertBloc>().add(PfmpInsert_Submit(
                        nomSociete.text,
                        adresseSoc.text,
                        statusJuri.text,
                        nomFormate.text,
                        contactFor.text,
                        dateDeb,
                        dateFin,
                        context
                        )),
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
