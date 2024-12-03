import 'package:advflutterexam/Modal/model.dart';
import 'package:advflutterexam/Services/firestroe.dart';

import 'package:advflutterexam/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class NotesController extends GetxController {
  var NotesList = <Note>[].obs;
  var note=[].obs;
  final DatabaseHelper dbHelper = DatabaseHelper();
  // final FirestoreService firestoreService=FirestoreService.();
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadContacts();
    searchController.addListener(searchContacts);
  }



  void loadContacts({String? query}) async {
    NotesList.value = await dbHelper.getContacts(query: query);
  }

  void insertUser(Note note) async {
    await dbHelper.insertContact(note);
    // syncContactsToFirestore();
    loadContacts();
  }

  void updateUser(Note note) async {
    await dbHelper.updateContact(note);
    // syncContactsToFirestore();
    loadContacts();
  }

  Future<void> deleteUser(String id) async {
    int contactId = int.tryParse(id) ?? -1;
    await dbHelper.deleteItem(contactId);
    loadContacts();
  }

  Future<void> syncContactsToFirestore() async {
    String userId = "currentUserId";
    await FirestoreService.firestoreService.syncNote(userId, NotesList);
  }

  Future<void> fetchContactsFromFirestore() async {
    String userId = "currentUserId";
    var cloudContacts = await FirestoreService.firestoreService.getNotes(userId);

    for (var contact in cloudContacts) {
      await dbHelper.insertContact(contact);
    }

    loadContacts();
  }

  void searchContacts() {
    String query = searchController.text;
    loadContacts(query: query);
  }
  Future<RxList> categroyWise(String email,String category)
  async {
  note.value= await dbHelper.selectData(email, category);
   return note;

  }

}

// import 'package:advflutterexam/Modal/model.dart';
// import 'package:advflutterexam/Services/firestroe.dart';
// import 'package:advflutterexam/helper/helper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class NotesController extends GetxController {
//   var NotesList = <Note>[].obs;
//   final DatabaseHelper dbHelper = DatabaseHelper();
//   final FirestoreService firestoreService = FirestoreService();
//   final TextEditingController searchController = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadContacts();
//     searchController.addListener(searchContacts);
//   }
//
//   void loadContacts({String? query}) async {
//     NotesList.value = await dbHelper.getContacts(query: query);
//   }
//
//   void insertUser(Note note) async {
//     await dbHelper.insertContact(note);
//     await syncContactsToFirestore(); // Sync to Firestore after local insert
//     loadContacts();
//   }
//
//   void updateUser(Note note) async {
//     await dbHelper.updateContact(note);
//     await syncContactsToFirestore(); // Sync to Firestore after update
//     loadContacts();
//   }
//
//   Future<void> deleteUser(String id) async {
//     int contactId = int.tryParse(id) ?? -1;
//     await dbHelper.deleteItem(contactId);
//     await syncContactsToFirestore(); // Sync to Firestore after deletion
//     loadContacts();
//   }
//
//   Future<void> syncContactsToFirestore() async {
//     String userId = "currentUserId"; // Replace with actual user ID logic
//     await firestoreService.syncNote(userId, NotesList);
//   }
//
//   Future<void> fetchContactsFromFirestore() async {
//     String userId = "currentUserId"; // Replace with actual user ID logic
//     var cloudContacts = await firestoreService.getNotes(userId);
//
//     for (var contact in cloudContacts) {
//       await dbHelper.insertContact(contact);
//     }
//
//     loadContacts();
//   }
//
//   void searchContacts() {
//     String query = searchController.text;
//     loadContacts(query: query);
//   }
// }
