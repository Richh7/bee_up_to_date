class Hive {

  final int id;
  int framesNumber;
  String queenColor;
  String qrCode;
  String? comments;
  final int apiaryId;

  Hive({
    required this.id,
    required this.framesNumber,
    required this.queenColor,
    required this.qrCode,
    this.comments,
    required this.apiaryId,
  });


  Map<String, dynamic> toMap() {
    return {'id': id, 'framesNumber': framesNumber, 'queenColor': queenColor,
      'qrCode': qrCode, 'comments': comments, 'apiaryId': apiaryId};
  }

  factory Hive.fromMap(Map<String, dynamic> hive) {
    return Hive(
        id: hive['id'],
        framesNumber: hive['framesNumber'],
        queenColor: hive['queenColor'],
        qrCode: hive['qrCode'],
        comments: hive['comments'],
        apiaryId: hive['apiaryId']
    );
  }

  @override
  String toString() {
    return 'Hive{id: $id, framesNumber: $framesNumber, '
        'queenColor: $queenColor, qr: $qrCode, comments: $comments, '
        'apiaryId: $apiaryId}';
  }
}
