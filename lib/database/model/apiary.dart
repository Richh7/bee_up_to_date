class Apiary {

  final int id;
  String name;
  String location;
  String? description;

  Apiary({
    required this.id,
    required this.name,
    required this.location,
    this.description,
  });


  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'location': location,
      'description': description};
  }

  factory Apiary.fromMap(Map<String, dynamic> apiary) {
    return Apiary(
        id: apiary['id'],
        name: apiary['name'],
        location: apiary['location'],
        description: apiary['description']
    );
  }

  @override
  String toString() {
    return 'Apiary{id: $id, name: $name, location: $location, '
        'description: $description}';
  }
}