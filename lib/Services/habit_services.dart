import 'package:advflutterexam/Model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HabitService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference
  final CollectionReference habitsCollection = FirebaseFirestore.instance.collection('habits');

  // Add a new habit
  Future<void> addHabit(HabitModal habit) async {
    try {
      await habitsCollection.add(habit.toMap());
    } catch (e) {
      print('Error adding habit: $e');
      throw e;
    }
  }

  // Get all habits
  Future<List<HabitModal>> getHabits() async {
    try {
      QuerySnapshot snapshot = await habitsCollection.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return HabitModal.fromMap({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      print('Error getting habits: $e');
      throw e;
    }
  }


}
