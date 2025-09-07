import 'dart:convert';

class Commune {
  final int? id;
  final String pachalikcircon;
  final String caidat;
  final String nom;
  final double latitude;
  final double longitude;

  const Commune(
      {this.id,
      required this.pachalikcircon,
      required this.caidat,
      required this.nom,
      required this.latitude,
      required this.longitude});

  factory Commune.fromJson(Map<String, dynamic> json) {
    return Commune(
      id: json['id'] as int?,
      pachalikcircon: json['pachalik-circon'] as String,
      caidat: json['caidat'] as String,
      nom: json['nom'] as String,
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
    );
  }
  Map toJson() => {
        'pachalik-circon': pachalikcircon,
        'caidat': caidat,
        'nom': nom,
        'latitude': latitude.toDouble(),
        'longitude': longitude.toDouble()
      };
}
