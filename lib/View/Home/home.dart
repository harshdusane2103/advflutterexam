import 'package:advflutterexam/Controller/Auth/auth.dart';
import 'package:advflutterexam/View/Auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:advflutterexam/Controller/controller.dart';
import 'package:advflutterexam/Model/model.dart';

class HomeScreen extends StatelessWidget {
  final ExerciseController exerciseController = Get.put(ExerciseController());
  final AuthController authController = Get.put(AuthController());


  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed:() async {
            await authController.logOut();
            Get.offAll(SignIn());
          },
        ),
        title: const Text(
          'Exercise Manager',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.sync, color: Colors.white),
            onPressed: () async {
              await exerciseController.syncToFirestore();
              Get.snackbar(
                'Sync Successful',
                'Exercise data synced to Firestore!',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.backup_outlined,
              color: Colors.white,
            ),
            onPressed: () async {
              await exerciseController.syncToFirestore();
              Get.snackbar('Backup successfully', 'Backup',snackPosition: SnackPosition.BOTTOM,);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) {
                // Implement search/filter logic if needed
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Search Exercises',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: exerciseController.exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exerciseController.exercises[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      title: Text(exercise.name ?? ''),
                      subtitle: Text(
                        '${exercise.type ?? ''} | ${exercise.intensity ?? ''} Intensity',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditExerciseDialog(context, exercise),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => exerciseController.deleteExercise(exercise.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => _showAddExerciseDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddExerciseDialog(BuildContext context) {
    final nameController = TextEditingController();
    final durationController = TextEditingController();
    final dateController = TextEditingController();
    final typeController = TextEditingController();
    final intensityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Exercise'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Exercise Name'),
                ),
                TextField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Duration (minutes)'),
                ),
                TextField(
                  controller: dateController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(labelText: 'Date (yyyy-MM-dd)'),
                ),
                TextField(
                  controller: typeController,
                  decoration: const InputDecoration(labelText: 'Type (e.g., Cardio)'),
                ),
                TextField(
                  controller: intensityController,
                  decoration: const InputDecoration(labelText: 'Intensity (Low, Medium, High)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Safely parse the duration
                final duration = int.tryParse(durationController.text);

                // Ensure the date is valid
                final date = DateTime.tryParse(dateController.text);

                if (duration == null || date == null) {
                  Get.snackbar(
                    'Invalid Input',
                    'Please provide valid values for Duration and Date.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                final exercise = ExerciseModel(
                  name: nameController.text,
                  duration: duration,
                  date: date.millisecondsSinceEpoch,
                  type: typeController.text,
                  intensity: intensityController.text,
                );

                exerciseController.addExercise(exercise);
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }


  void _showEditExerciseDialog(BuildContext context, ExerciseModel exercise) {
    final nameController = TextEditingController(text: exercise.name);
    final durationController = TextEditingController(
      text: exercise.duration?.toString() ?? '',
    );
    final dateController = TextEditingController(
      text: DateTime.fromMillisecondsSinceEpoch(exercise.date ?? 0)
          .toIso8601String()
          .split('T')
          .first,
    );
    final typeController = TextEditingController(text: exercise.type);
    final intensityController = TextEditingController(text: exercise.intensity);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Exercise'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Exercise Name'),
                ),
                TextField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Duration (minutes)'),
                ),
                TextField(
                  controller: dateController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(labelText: 'Date (yyyy-MM-dd)'),
                ),
                TextField(
                  controller: typeController,
                  decoration: const InputDecoration(labelText: 'Type (e.g., Cardio)'),
                ),
                TextField(
                  controller: intensityController,
                  decoration: const InputDecoration(labelText: 'Intensity (Low, Medium, High)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Safely parse the duration value
                final duration = int.tryParse(durationController.text);

                // Ensure the date is valid
                final date = DateTime.tryParse(dateController.text);

                if (duration == null || date == null) {
                  Get.snackbar(
                    'Invalid Input',
                    'Please provide valid values for Duration and Date.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                final updatedExercise = ExerciseModel(
                  id: exercise.id,
                  name: nameController.text,
                  duration: duration,
                  date: date.millisecondsSinceEpoch,
                  type: typeController.text,
                  intensity: intensityController.text,
                );

                // Update the exercise via the controller
                exerciseController.updateExercise(updatedExercise);
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

}
