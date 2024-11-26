import 'package:advflutterexam/Model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> syncExercises(String userId, List<ExerciseModel> exercises) async {
    final batch = _firestore.batch();
    final userRef = _firestore.collection('users').doc(userId).collection('exercises');

    for (var exercise in exercises) {
      final docRef = userRef.doc(exercise.id?.toString() ?? exercise.name);
      batch.set(docRef, exercise.toMap());
    }

    await batch.commit();
  }

  Future<List<ExerciseModel>> fetchExercises(String userId) async {
    final snapshot = await _firestore.collection('users').doc(userId).collection('exercises').get();
    return snapshot.docs
        .map((doc) => ExerciseModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
