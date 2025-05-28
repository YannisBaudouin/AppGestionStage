class Pfmp {
  late String nomSociete;
  late String adresseSociete;
  late String statusSociete;
  late String nomFormateur;
  late String contactFormateur;
  late DateTime dateDebut;
  late DateTime dateFin;

  Pfmp(
    String nomSoc,
    String adresseSoc,
    String statusSoc,
    String nomForma,
    String contactForma,
    DateTime dateD,
    DateTime dateF,
  ) {
    this.nomSociete = nomSoc;
    this.adresseSociete = adresseSoc;
    this.statusSociete = statusSoc;
    this.nomFormateur = nomForma;
    this.contactFormateur = contactForma;
    this.dateDebut = dateD;
    this.dateFin = dateF;
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

  DateTime getDateDebut() {
    return this.dateDebut;
  }

  void setdateDebut(DateTime nouvDateDebut) {
    this.dateDebut = nouvDateDebut;
  }

  DateTime getDateFin() {
    return this.dateFin;
  }

  void setDateFin(DateTime nouvDateFin) {
    this.dateFin = nouvDateFin;
  }
}
