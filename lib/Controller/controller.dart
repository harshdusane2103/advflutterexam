import 'package:advflutterexam/Helper/database.dart';
import 'package:advflutterexam/Model/model.dart';
import 'package:advflutterexam/Services/firestroe.dart';
import 'package:get/get.dart';


class ExerciseController extends GetxController {
  var exercises = <ExerciseModel>[].obs;
  final dbHelper = DatabaseHelper();
  final firestoreService = FirestoreService();
  String? userId; // Set this from Firebase Auth

  @override
  void onInit() {
    super.onInit();
    fetchExercises();
  }

  void fetchExercises() async {
    exercises.value = await dbHelper.getExercises();
  }

  void addExercise(ExerciseModel exercise) async {
    await dbHelper.insertExercise(exercise);
    await syncToFirestore();
    fetchExercises();
  }

  void updateExercise(ExerciseModel exercise) async {
    await dbHelper.updateExercise(exercise);
    await syncToFirestore();
    fetchExercises();
  }

  void deleteExercise(int id) async {
    await dbHelper.deleteExercise(id);
    fetchExercises();
  }

  Future<void> syncToFirestore() async {
    if (userId == null) return;
    await firestoreService.syncExercises(userId!, exercises.toList());
  }
}
