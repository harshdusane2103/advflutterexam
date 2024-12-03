import 'package:advflutterexam/Controller/AuthController.dart';
import 'package:advflutterexam/Controller/controller.dart';
import 'package:advflutterexam/Modal/model.dart';
import 'package:advflutterexam/Services/firestroe.dart';
import 'package:advflutterexam/View/singin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
final  NotesController notesController = Get.put(NotesController());
final AuthController authController = Get.put(AuthController());
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          backgroundColor:Colors.deepPurple,
          title: Text(
            'Note',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.sync,
                color: Colors.white,
              ),
              onPressed:()  async {


                await notesController.syncContactsToFirestore();

                Get.snackbar('Data successfully add in firestore', 'Sync',snackPosition: SnackPosition.BOTTOM,);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.backup_outlined,
                color: Colors.white,
              ),
              onPressed: () async {
                await notesController.fetchContactsFromFirestore();

                Get.snackbar('Backup successfully', 'Backup',snackPosition: SnackPosition.BOTTOM,);
              },
            ),

          ],


          centerTitle: true,
        ),
        body: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: notesController.searchController,
                onChanged: (value) {},
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.teal,
                        )),
                    child: const Center(
                        child: Text(
                          'Personal',
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {

                      notesController.categroyWise(authController.txtEmail.text, 'category');
                      // notesController.NotesList[index].title!
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.teal,
                        ),
                      ),
                      child: const Center(
                          child: Text(
                            'Work',
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.teal,
                        )),
                    child: const Center(
                        child: Text(
                          'Job',
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        )),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: notesController.NotesList.length,
                  itemBuilder: (context, index) {
                    final notes = notesController.NotesList[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 0
                      ),
                      child: Card(
                        child: ListTile(
                          title: Text(notes.title),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(notes.category),
                              Text(notes.dateCreated),
                              Text(notes.priority),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () =>
                                    _showEditContactDialog(context, notes),
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete, color: Colors.redAccent),
                                  onPressed: () =>
                                      notesController.deleteUser(notes.id.toString())),
                            ],
                          ),
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
          backgroundColor: Colors.deepPurple,
          onPressed: () => _showAddContactDialog(context),
          child: Icon(Icons.add, color: Colors.white),
        )




    );

  }

  void _showAddContactDialog(BuildContext context) {
    final titleController = TextEditingController();
    final categoryController = TextEditingController();
    final contentController = TextEditingController();
    final dateController = TextEditingController();
    final priorityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('ADD NOTE'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title')),
              TextField(
                  controller: dateController,
                  decoration: InputDecoration(labelText: 'Date')),
              TextField(
                  controller: categoryController,
                  decoration: InputDecoration(labelText: 'Category')),
              TextField(
                  controller: contentController,
                  decoration: InputDecoration(labelText: 'Content')),
              TextField(
                  controller: priorityController,
                  decoration: InputDecoration(labelText: 'Priortiy (High,Medium,Low )')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final note = Note(
                  title: titleController.text,
                  dateCreated: dateController.text,
                  category: categoryController.text,
                  content: contentController.text,
                  priority: priorityController.text,

                );
                notesController.insertUser(note);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showEditContactDialog(BuildContext context, Note note) {

    final titleController = TextEditingController();
    final categoryController = TextEditingController();
    final contentController = TextEditingController();
    final dateController = TextEditingController();
    final priorityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title')),
              TextField(
                  controller: dateController,
                  decoration: InputDecoration(labelText: 'Date')),
              TextField(
                  controller: categoryController,
                  decoration: InputDecoration(labelText: 'Category')),
              TextField(
                  controller: contentController,
                  decoration: InputDecoration(labelText: 'Content')),
              TextField(
                  controller: priorityController,
                  decoration: InputDecoration(labelText: 'Priortiy (High,Medium,Low )')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedContact = Note(
                  id: note.id,
                  title: titleController.text,
                  dateCreated: dateController.text,
                  category: categoryController.text,
                  content: contentController.text,
                  priority: priorityController.text,

                );
                notesController.updateUser(updatedContact);
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
