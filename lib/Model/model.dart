import 'package:cloud_firestore/cloud_firestore.dart';

class HabitModal {
  int? id, days;
  String? name, progress;

  HabitModal(this.id, this.name, this.days, this.progress);

  factory HabitModal.fromMap(Map m1)
  {
    return HabitModal(m1['id'] ?? '', m1['name'] ?? '', m1['days'] ?? '',
        m1['progress'] ?? '');
  }


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'days': days,
      'progress': progress,

    };
  }
}


