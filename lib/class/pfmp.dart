class Pfmp {
  late String nomSociete;
  late String adresseSociete;
  late String statusSociete;
  late String nomFormateur;
  late String contactFormateur;
  late DateTime periodeStage;

  Pfmp(
    String nomSoc,
    String adresseSoc,
    String statusSoc,
    String nomForma,
    String contactForma,
    DateTime periode,
  ) {
    this.nomSociete = nomSoc;
    this.adresseSociete = adresseSoc;
    this.statusSociete = statusSoc;
    this.nomFormateur = nomForma;
    this.contactFormateur = contactForma;
    this.periodeStage = periode;
  }

  String getNomSociete() {
    return this.nomSociete;
  }

  void setNomSociete(String nouvNom) {
    this.nomSociete = nouvNom;
  }

  String getAdresseSociete() {
    return this.adresseSociete;
  }

  void setAdresseSociete(String nouvAdresse) {
    this.adresseSociete = nouvAdresse;
  }

  String getStatusSociete() {
    return this.statusSociete;
  }

  void setStatusSociete(String nouvStatus) {
    this.statusSociete = nouvStatus;
  }

  String getNomFormateur() {
    return this.nomFormateur;
  }

  void setNomFormateur(String nouvNomForma) {
    this.nomFormateur = nouvNomForma;
  }

  String getContactFormateur() {
    return this.contactFormateur;
  }

  void setContactFormateur(String nouvContact) {
    this.nomSociete = nouvContact;
  }

  DateTime getPeriodeStage() {
    return this.periodeStage;
  }

  void setPeriodeStage(DateTime nouvPeriode) {
    this.periodeStage = nouvPeriode;
  }
}
