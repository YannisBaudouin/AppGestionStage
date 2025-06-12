import 'dart:io';

import 'package:app_gestion_stage/class/pfmp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/services.dart' show rootBundle, ByteData, Uint8List;
import 'package:syncfusion_flutter_pdf/pdf.dart';

part 'pfmp_profil_event.dart';
part 'pfmp_profil_state.dart';

class PfmpProfilBloc extends Bloc<PfmpProfilEvent, PfmpProfilState> {
  PfmpProfilBloc() : super(const PfmpProfilInitial()) {
    on<PfmpProfil_GetInfos>(_getInfo);
    on<PfmpProfil_ConvertToPdf>(_convertToPdf);
  }

  Pfmp? targetPfmp;

  void _getInfo(
    PfmpProfil_GetInfos event,
    Emitter<PfmpProfilState> emit,
  ) async {
    if (event.pfmpId != null) {
      targetPfmp = await Pfmp.retrieve(event.pfmpId.toString());
    }

    emit(PfmpProfilInitialized());
  }

  void _convertToPdf(
    PfmpProfil_ConvertToPdf event,
    Emitter<PfmpProfilState> emit,
  ) async {
    final ByteData bytes = await rootBundle.load('assets/pfmpPdf.pdf');
    final Uint8List list = bytes.buffer.asUint8List();
    final PdfDocument document = PdfDocument(inputBytes: list);

    PdfTextBoxField tb_nomSociete = document.form.fields[0] as PdfTextBoxField;
    tb_nomSociete.text = targetPfmp!.nomSociete;

    PdfTextBoxField tb_adresse = document.form.fields[1] as PdfTextBoxField;
    tb_adresse.text = targetPfmp!.adresseSociete;

    PdfTextBoxField tb_statusJur = document.form.fields[2] as PdfTextBoxField;
    tb_statusJur.text = targetPfmp!.statusSociete;

    PdfTextBoxField tb_nomForma = document.form.fields[3] as PdfTextBoxField;
    tb_nomForma.text = targetPfmp!.nomFormateur;

    PdfTextBoxField tb_contactFormateur = document.form.fields[4] as PdfTextBoxField;
    tb_contactFormateur.text = targetPfmp!.contactFormateur;

    PdfTextBoxField tb_dateFin = document.form.fields[5] as PdfTextBoxField;
    tb_dateFin.text = targetPfmp!.dateFin.toString().split(" ")[0];

    PdfTextBoxField tb_dateDeb = document.form.fields[6] as PdfTextBoxField;
    tb_dateDeb.text = targetPfmp!.dateDebut.toString().split(" ")[0];

    //final directory = await getExternalStorageDirectories();
    final File file = File('/storage/emulated/0/Download/${targetPfmp!.nomSociete}.pdf');
    if (file.existsSync()) { await file.delete(); }

    document.form.flattenAllFields();

    List<int> savedPdf = await document.save();
    await file.writeAsBytes(savedPdf);

    document.dispose();
  }
}
