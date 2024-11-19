import 'package:advflutterexam/Controller/controller.dart';
import 'package:advflutterexam/Services/Auth_services.dart';
import 'package:advflutterexam/View/Auth/auth.dart';
import 'package:advflutterexam/View/componts/entry.dart';
import 'package:advflutterexam/View/componts/update.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
var controller=Get.put(HabitController());
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    leading: CircleAvatar(
      child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOH2aZnIHWjMQj2lQUOWIL2f4Hljgab0ecZQ&s'),
    ),
    centerTitle: true,
    title: Text('Habits'),
    actions: [

      IconButton(onPressed: () {
        AuthServices.userServices.signOut();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SingInScreen()));

      }, icon: Icon(Icons.logout))
    ],
  ),

      body: Obx(()=>ListView.builder(itemCount:controller.HabitList.length,itemBuilder: (context, index) => ListTile(
        leading: Text(controller.HabitList[index].id.toString()),
        title: Text(controller.HabitList[index].name!),
        subtitle: Text(controller.HabitList[index].days.toString()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(controller.HabitList[index].progress!),

            GestureDetector(onTap: () {
              showDialog(context: context, builder:(context)=>updateDateDailog(controller,index, controller.HabitList[index].id!));
            },
                child: Icon(Icons.edit)),
            GestureDetector(onTap:(){
              controller.deleteData(controller.HabitList[index].id!);
            },child: Icon(Icons.delete)),
          ],
        ),
      ),)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          showDialog(context: context,builder: (context)=>entryDialog(controller));


        },
      child: Icon(Icons.add),),
    );
  }
}
