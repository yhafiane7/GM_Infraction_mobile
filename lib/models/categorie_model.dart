class Categorie {
  final int? id;
  final String nom;
  final int degre;

  const Categorie({
    this.id,
    required this.nom,
    required this.degre,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      id: json['id'] as int?,
      nom: json['nom'] as String,
      degre: json['degre'] as int,
    );
  }
  Map toJson() => {
        'nom': nom,
        'degre': degre.toInt(),
      };
}
