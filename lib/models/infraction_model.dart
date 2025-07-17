import 'dart:convert';

class Infraction {
  final int? id;
  final String nom;
  final String date;
  final String adresse;
  final int commune_id;
  final int violant_id;
  final int agent_id;
  final int categorie_id;
  final double latitude;
  final double longitude;

  Infraction({
    this.id,
    required this.nom,
    required this.date,
    required this.adresse,
    required this.commune_id,
    required this.violant_id,
    required this.agent_id,
    required this.categorie_id,
    required this.latitude,
    required this.longitude,
  });

  factory Infraction.fromJson(Map<String, dynamic> json) {
    return Infraction(
      id: json['id'] as int?,
      nom: json['nom'] as String,
      date: json['date'] as String,
      adresse: json['adresse'] as String,
      commune_id: json['commune_id'] as int,
      violant_id: json['violant_id'] as int,
      agent_id: json['agent_id'] as int,
      categorie_id: json['categorie_id'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'date': date,
        'adresse': adresse,
        'commune_id': commune_id.toString(),
        'violant_id': violant_id.toString(),
        'agent_id': agent_id.toString(),
        'categorie_id': categorie_id.toString(),
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      };
}
