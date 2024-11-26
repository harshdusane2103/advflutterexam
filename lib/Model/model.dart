class ExerciseModel {
  int? id;
  String name;
  int duration; // in minutes
  int date; // epoch timestamp
  String type; // Cardio, Strength, etc.
  String intensity; // Low, Medium, High

  ExerciseModel({
    this.id,
    required this.name,
    required this.duration,
    required this.date,
    required this.type,
    required this.intensity,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      duration: map['duration'] as int,
      date: map['date'] as int,
      type: map['type'] as String,
      intensity: map['intensity'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'date': date,
      'type': type,
      'intensity': intensity,
    };
  }
}

