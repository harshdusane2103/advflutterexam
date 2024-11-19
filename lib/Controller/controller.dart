
      import 'package:advflutterexam/Helper/database.dart';
import 'package:advflutterexam/Model/model.dart';
import 'package:flutter/cupertino.dart';
      import 'package:get/get.dart';



      class HabitController extends GetxController

          {
          RxList<HabitModal> HabitList=<HabitModal>[].obs;
          TextEditingController txtId=TextEditingController();
          TextEditingController txtname=TextEditingController();
          TextEditingController txtdays=TextEditingController();
          TextEditingController txtprogress=TextEditingController();
          // DatabaseHelper? databaseHelper;
          @override
          void onInit()
          {
          super.onInit();
          fetchData();
          }
          Future<void> fetchData()
          async {
          await DbHelper.dbHelper.database;
          readDataCome();
          }

          Future<void> readDataCome()
          async {
          List data = await DbHelper.dbHelper.readData();
          HabitList.value = data.map((e)=>HabitModal.fromMap(e),).toList();
          }

          void insertRecords(HabitModal student)
          async {
          await DbHelper.dbHelper.insertData(student);
          readDataCome();
          }
          void updataRecords(HabitModal student,int index)
          {
          DbHelper.dbHelper.updateData(student, index);

          readDataCome();
          }
          void deleteData(int id)
          {
          DbHelper.dbHelper.deleteData(id);
          fetchData();
          }


          }