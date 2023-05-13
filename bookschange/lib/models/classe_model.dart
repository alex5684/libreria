import 'dart:ffi';

class Classe{
  String nome;
  List<Materia> materie;

  Classe({required this.nome, required this.materie});
}

class Materia {
  late String nome;
  late Libro libro;
  late Contatto contatto;


  Materia({required this.nome, required this.libro});

  Materia.fromJson(Map<dynamic,dynamic> json){
    nome = json["nome"];
    libro = json["libro"];
  }

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'libro': libro,
  };
}

class Libro {
  late Bool disponibile;
  late Contatto contatto;
  late Testo testo;

  Libro({
    required this.disponibile,
    required this.contatto,
    required this.testo
  });

  Libro.fromJson(Map<dynamic,dynamic> json){
    disponibile = json["disponibile"];
    contatto = json["contatto"];
    testo = json["testo"];
  }

  Map<String, dynamic> toJson() => {
    'disponibile': disponibile,
    'contatto': contatto,
    'testo' : testo,
  };
}

class Contatto {
  late String nome;
  late String cognome;
  late String email;
  late String telefono;

  Contatto({
    required this.nome,
    required this.cognome,
    required this.email,
    required this.telefono
  });

  Contatto.fromJson(Map<dynamic,dynamic> json){
    nome = json["nome"];
    cognome = json["cognome"];
    email = json["email"];
    telefono = json["telefono"];
  }

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'cognome': cognome,
    'email' : email,
    'telefono' : telefono,
  };
}

class Testo{
  late String titolo;
  late double prezzo;
  late String condizione;

  Testo({
    required this.titolo,
    required this.prezzo,
    required this.condizione
  });

  Testo.fromJson(Map<dynamic,dynamic> json){
    titolo = json["titolo"];
    prezzo = json["prezzo"].toDouble();
    condizione = json["condizione"];
  }

  Map<String, dynamic> toJson() => {
    'titolo': titolo,
    'prezzo': prezzo,
    'condizione' : condizione,
  };
}
