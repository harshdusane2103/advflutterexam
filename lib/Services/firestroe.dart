
import 'package:advflutterexam/Controller/controller.dart';
import 'package:advflutterexam/Modal/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final  NotesController notesController = Get.put(NotesController());

class FirestoreService {
  FirestoreService._();
  static FirestoreService firestoreService=FirestoreService._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Note>> getNotes(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('contacts')
          .get();

      return snapshot.docs.map((doc) {
        final note = Note.fromMap(doc.data() as Map<String, dynamic>);
        note.id = int.parse(doc.id); // No casting needed; id is already a String
        return note;
      }).toList();
    } catch (e) {
      print('Error fetching notes: $e');
      return [];
    }
  }



  Future<void> syncNote(String userId, List<Note> notesList) async {
    final batch = _firestore.batch();
    final userContactsRef =
    _firestore.collection('users').doc(userId).collection('contacts');

    for (var note in notesList) {
      final docRef = userContactsRef.doc(note.id?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString());
      batch.set(docRef, note.toMap());
    }

    await batch.commit();
  }


}

