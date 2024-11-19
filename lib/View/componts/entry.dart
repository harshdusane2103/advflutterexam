import 'package:flutter/material.dart';
import 'package:advflutterexam/Controller/controller.dart';
import 'package:advflutterexam/Model/model.dart';
import 'package:get/get.dart';

Widget entryDialog(HabitController Controller)
{
        return AlertDialog( title: Text('Enter Data'),

        content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
                TextField(decoration: InputDecoration(labelText:('ID') ),controller: Controller.txtId,),
                TextField(decoration: InputDecoration(labelText:('Name') ),controller: Controller.txtname,),
                TextField(decoration: InputDecoration(labelText:('Habits Days') ),controller: Controller.txtdays,),
                TextField(decoration: InputDecoration(labelText:('Habit Progress') ),controller: Controller.txtprogress,),
                TextButton(
            onPressed: () {
                  Get.back();
        }, child: Text('Cancel')),
                TextButton(onPressed: () {
                int id=int.parse(Controller.txtId.text);
                String name=Controller.txtname.text;
                int day=int.parse(Controller.txtdays.text);
                String progress=Controller.txtprogress.text;
                HabitModal habit=HabitModal(id,name,day,progress);
                 Controller.insertRecords(habit);


                 Get.back();
                Controller.txtId.clear();
                Controller.txtname.clear();
                 Controller.txtdays.clear();
                Controller.txtprogress.clear();


                }, child: Text('save'))
        ],
        ),
        );
        }
