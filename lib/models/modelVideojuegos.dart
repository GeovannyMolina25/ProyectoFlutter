import 'dart:convert';

Videojuego videojuegoFromJson(String str) =>
    Videojuego.fromJson(json.decode(str));

String videojuegoToJson(Videojuego data) => json.encode(data.toJson());

class Videojuego {
  int? id;
  String? nombrejuego;
  String? genero ;
  String? aniolanzamiento ;
  String? clasificacion ;
  String? precio ;
  String? idiomas ;

  
  Videojuego({
    required this.id,
    required this.nombrejuego,
    required this.genero ,
    required this.aniolanzamiento ,
    required this.clasificacion ,
    required this.precio ,
    required this.idiomas ,
  });

  //int? id;
  //String? nombrejuego;
  //String? nombrejuego;
  //"nombrejuego": "Leanne Graham",
  //"genero ": "Bret",
  //int? genero ;
  //String? genero;

  factory Videojuego.fromJson(Map<String, dynamic> json) => Videojuego(
        id: json["id"],
        nombrejuego: json["nombrejuego"],
        genero : json["genero "],
        aniolanzamiento : json["aniolanzamiento "],
        clasificacion : json["clasificacion "],
        precio : json["precio "],
        idiomas : json["idiomas "],
      );

  factory Videojuego.init() => Videojuego(
        id: 0,
        nombrejuego: "Goat Simulator 3",
        genero : "Simulator",
        aniolanzamiento : "1500",
        clasificacion : "+18",
        precio : "10.00",
        idiomas : "Ingles",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombrejuego": nombrejuego,
        "genero ": genero ,
        "aniolanzamiento ": aniolanzamiento ,
        "clasificacion ": aniolanzamiento ,
        "precio ": aniolanzamiento ,
        "idiomas ": aniolanzamiento ,
      };

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nombrejuego": nombrejuego,
      "genero ": genero ,
      "aniolanzamiento ": aniolanzamiento ,
      "clasificacion ": aniolanzamiento ,
      "precio ": aniolanzamiento ,
      "idiomas ": aniolanzamiento ,
    };
  }
}
