class Inspection {

  final int id;
  String date;
  bool queenSeen;
  bool eggsSeen;
  bool cellsSeen;
  String strength;
  String? comments;
  final int hiveId;

  Inspection({
    required this.id,
    required this.date,
    required this.queenSeen,
    required this.eggsSeen,
    required this.cellsSeen,
    required this.strength,
    this.comments,
    required this.hiveId,
  });


  Map<String, dynamic> toMap() {
    return {'id': id, 'date': date, 'queenSeen': queenSeen,
      'eggsSeen': eggsSeen, 'cellsSeen': cellsSeen, 'strength': strength,
      'comments': comments, 'hiveId': hiveId};
  }

  factory Inspection.fromMap(Map<String, dynamic> inspection) {
    return Inspection(
        id: inspection['id'],
        date: inspection['date'],
        queenSeen: inspection['queenSeen'],
        eggsSeen: inspection['eggsSeen'],
        cellsSeen: inspection['cellsSeen'],
        strength: inspection['strength'],
        comments: inspection['comments'],
        hiveId: inspection['hiveId']
    );
  }

  @override
  String toString() {
    return 'Inspection{id: $id, date: $date, queen: $queenSeen,'
        'eggs: $eggsSeen, cells: $cellsSeen, strength: $strength, '
        'comments: $comments, apiaryId: $hiveId}';
  }
}