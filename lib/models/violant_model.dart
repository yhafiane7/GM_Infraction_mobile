class Violant {
  final int? id;
  final String nom;
  final String prenom;
  final String cin;

  const Violant(
      {this.id, required this.nom, required this.prenom, required this.cin});

  factory Violant.fromJson(Map<String, dynamic> json) {
    return Violant(
      id: json['id'] as int?,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      cin: json['cin'] as String,
    );
  }
  Map toJson() => {'nom': nom, 'prenom': prenom, 'cin': cin};
}
