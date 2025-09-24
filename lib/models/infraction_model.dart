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
      commune_id: int.parse(json['commune_id'].toString()),
      violant_id: int.parse(json['violant_id'].toString()),
      agent_id: int.parse(json['agent_id'].toString()),
      categorie_id: int.parse(json['categorie_id'].toString()),
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
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
