import 'dart:convert';

class Decision {
  final int? id;
  final String date;
  final String decisionPrise;
  final int infractionId;

  Decision({
    this.id,
    required this.date,
    required this.decisionPrise,
    required this.infractionId,
  });

  factory Decision.fromJson(Map<String, dynamic> json) {
    return Decision(
      id: json['id'] as int?,
      date: json['date'] as String,
      decisionPrise: json['decisionprise'] as String,
      infractionId: int.parse(json['infraction_id'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'decisionprise': decisionPrise,
        'infraction_id': infractionId.toInt(),
      };
}
