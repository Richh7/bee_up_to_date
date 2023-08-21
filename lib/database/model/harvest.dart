class Harvest {

  final int id;
  String date;
  String honeyType;
  double weight;
  double? waterPercentage;
  String? comments;
  final int apiaryId;

  Harvest({
    required this.id,
    required this.date,
    required this.honeyType,
    required this.weight,
    this.waterPercentage,
    this.comments,
    required this.apiaryId,
  });


  Map<String, dynamic> toMap() {
    return {'id': id, 'date': date, 'honeyType': honeyType,
      'weight': weight, 'waterPercentage': waterPercentage,
      'comments': comments, 'apiaryId': apiaryId};
  }

  factory Harvest.fromMap(Map<String, dynamic> harvest) {
    return Harvest(
        id: harvest['id'],
        date: harvest['date'],
        honeyType: harvest['honeyType'],
        weight: harvest['weight'],
        waterPercentage: harvest['waterPercentage'],
        comments: harvest['comments'],
        apiaryId: harvest['apiaryId']
    );
  }

  @override
  String toString() {
    return 'Harvest{id: $id, date: $date, honeyType: $honeyType,'
        'weight: $weight, water%: $waterPercentage, comments: $comments,'
        'apiaryId: $apiaryId}';
  }
}