
class Book{
  String key;
  BookData bookData;

  Book({required this.key, required this.bookData});
}

class BookData{
  late String nome;
  late String cognome;
  late String email;
  late String telefono;
  late String classe;
  late String materia;
  late String titolo;
  late String condizioni;
  late double prezzo;
  late bool disponibile;
  late String proprietario;

  BookData({
    required this.nome,
    required this.cognome,
    required this.email,
    required this.telefono,
    required this.classe,
    required this.materia,
    required this.titolo,
    required this.condizioni,
    required this.prezzo,
    required this.disponibile,
    required this.proprietario
  });

  BookData.fromJson(Map<dynamic,dynamic> json){
    nome = json["nome"];
    cognome = json["cognome"];
    email = json["email"];
    telefono = json["telefono"];
    classe = json["classe"];
    materia = json["materia"];
    titolo = json["titolo"];
    condizioni = json["condizioni"];
    prezzo = json["prezzo"].toDouble();
    disponibile = json["disponibile"];
    proprietario=json["proprietario"];
  }

  Map<String, dynamic> toJson() => {
    "nome" : nome,
    "cognome" : cognome,
    "email" : email,
    "telefono" : telefono,
    "classe" : classe,
    "materia" : materia,
    "titolo" : titolo,
    "condizioni" : condizioni,
    "prezzo" : prezzo,
    "disponibile" : disponibile,
    "propietario":proprietario
  };
}

