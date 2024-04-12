import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    attendanceRef.snapshots().listen((event) {
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
}