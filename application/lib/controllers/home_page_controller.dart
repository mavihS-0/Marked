import 'dart:io';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_app_file/open_app_file.dart';

import '../data/attendance_model.dart';

class HomePageController extends GetxController {
  CollectionReference attendanceRef = FirebaseFirestore.instance.collection('attendance');
  List<Attendance> attendance = [];

  @override
  void onInit() {
    // TODO: implement onInit
    fetchData();
    super.onInit();
  }

  void fetchData() {
    attendanceRef.orderBy('time',descending: true).snapshots().listen((event) {
      attendance.clear();
      event.docs.forEach((element) {
        Map<String,dynamic> dataMap = element.data() as Map<String,dynamic>;
        dataMap['id'] = element.id;
        attendance.add(Attendance.fromMap(dataMap));
      });
      update();
    });
  }

  void deleteAttendee(String docId, String regNo){
    attendanceRef.doc(docId).update({
      'attendees': FieldValue.arrayRemove([regNo])
    });
  }

  void addAttendee(String docId, String regNo){
    attendanceRef.doc(docId).update({
      'attendees': FieldValue.arrayUnion([regNo])
    });
  }

  void downloadAttendance(int attendanceIndex) async {
    try{
      List<String> data = ['Reg No'];
      data.addAll(attendance[attendanceIndex].attendees);
      List<List<dynamic>> csvData = [
        ['Reg No'], // Header
        ...attendance[attendanceIndex].attendees.map((row) => [row]) // Rows
      ];
      String csv = const ListToCsvConverter().convert(csvData);
      // final directory = await getDownloadsDirectory();
      final dateWithUnderscore = attendance[attendanceIndex].date.replaceAll('/', '_');
      final fileName = '${attendance[attendanceIndex].slot}_$dateWithUnderscore.csv';
      final filePath = '/storage/emulated/0/Download/Marked/$fileName';
      Directory directory = Directory('/storage/emulated/0/Download/Marked/');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      File file = File(filePath);
      await file.writeAsString(csv);
      Get.snackbar('File Saved Successfully', 'Path: Download/Marked/$fileName');
      OpenAppFile.open(filePath);
    }
    catch(e){
      Get.snackbar('Error', e.toString());
    }

  }
}