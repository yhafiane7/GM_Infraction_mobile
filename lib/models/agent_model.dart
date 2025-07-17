import 'dart:convert';

class Agent {
  final int? id;
  final String nom;
  final String prenom;
  final String tel;
  final String cin;

  Agent(
      {this.id,
      required this.nom,
      required this.prenom,
      required this.tel,
      required this.cin});

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json['id'] as int?,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      tel: json['tel'] as String,
      cin: json['cin'] as String,
    );
  }
  Map<String, dynamic> toJson() =>
      {'nom': nom, 'prenom': prenom, 'tel': tel, 'cin': cin};
}
