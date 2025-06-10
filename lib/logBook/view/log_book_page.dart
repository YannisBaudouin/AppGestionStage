import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/log_book_bloc.dart';

import 'package:app_gestion_stage/customWidget/custom_widget.dart';

class LogBookPage extends StatelessWidget {
  final String pfmpId;
  const LogBookPage({super.key, required this.pfmpId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LogBookBloc(),
      child: LogBookView(pfmpId: pfmpId),
    );
  }
}

class LogBookView extends StatelessWidget {
  final String pfmpId;
  const LogBookView({super.key, required this.pfmpId});

  static final TextEditingController contentController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogBookBloc, LogBookState>(
      buildWhen: (prev, state) => true, //prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        switch (state) {
          case LogBookUnititialized():
            context.read<LogBookBloc>().add(InitLogBook(pfmpId));
          case LogBookInitialized():
            context.read<LogBookBloc>().add(LoadLogDay());
          default:
        }

        // Récupère le contenu du jour sauvegardé
        if (context.read<LogBookBloc>().logDay != null &&
            context.read<LogBookBloc>().logDay!.content.isNotEmpty) {
          contentController.text = context.read<LogBookBloc>().logDay!.content;
        } else {
          contentController.text = "";
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("Carnet de bord"),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {
                // Si le contenu a été modifié, alors afficher une page de confirmation
                if (context.read<LogBookBloc>().logDay?.content !=
                    contentController.text) {
                  customShowDialog(
                    context,
                    "Sauvegarder ?",
                    "Êtes vous sur de vouloir quitter sans sauvegarder ? Tout changement sera perdu.",
                    [
                      CustomREB(context: context, text: "Oui", popParentContext: true),
                      CustomREB(context: context, text: "Non"),
                    ],
                  );
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
            actions: [
              // Bouton calendrier
              CustomEB(
                text: context.read<LogBookBloc>().selectedDate.toString().split(
                  " ",
                )[0],
                pressed: () => context.read<LogBookBloc>().add(
                  UpdateSelectedDate(context),
                ),
                context: context,
              ),
            ],
          ),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Contenu du carnet de bord
                SizedBox(
                  width: 400,
                  height: 500,
                  child: CustomTF(
                    controller: contentController,
                    context: context,
                    hintText: "Vos tâches du jour",
                    helperText: null,
                    cacher: false,
                    maxLines: 20,
                  ),
                ),
                // Bouton sauvegarder
                CustomEB(
                  text: "Sauvegarder",
                  pressed: () => context.read<LogBookBloc>().add(
                    SaveLogDay(contentController.text, context),
                  ),
                  context: context,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
