import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mark_it/presentation/screens/attendance_page.dart';
import 'package:mark_it/presentation/screens/home_page.dart';

class AddAttendanceController extends GetxController {
  RxString date = '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}'.obs;
  TextEditingController slotController = TextEditingController();
  List <String> selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  TextEditingController urlController = TextEditingController(text: 'http://192.168.29.233:5000');
  CollectionReference attendanceRef = FirebaseFirestore.instance.collection('attendance');
  String docID = '';

  Future<void> pickImages() async {
    final images = await _picker.pickMultiImage();
    selectedImages.addAll(images.map((image)
    {
      return image.path;
    }));
    update();
    if(selectedImages.isEmpty){
      Get.back();
    }
  }


  Future<void> addAttendanceData() async{
    Map <String,dynamic> newData = {
      'date' : date.value,
      'slot' : slotController.text,
      'images' : [],
      'time': DateTime.now(),
      'attendees': []
    };
    try{
      for (var element in selectedImages) {
        final storageRef = FirebaseStorage.instance.ref().child(slotController.text+ '_' + DateTime.now().toString());
        final task = await storageRef.putFile(File(element), SettableMetadata(contentType: 'image/jpeg'));
        final snapshot = await task;
        final url = await snapshot.ref.getDownloadURL();
        newData['images'].add(url);
      }
      await attendanceRef.add(newData).then((docSnapshot)=> docID = docSnapshot.id);
    }
    catch(e){
      Get.snackbar('Error', e.toString());
    }
    var url = Uri.parse('${urlController.text}/attendance?docId=$docID');
    var response =  await http.get(url);
    if (response.statusCode == 200 ){
      Get.snackbar('Success', 'Attendance added successfully');
    }
    else {
      Get.snackbar('Error', 'Failed to get attendees');
    }
    selectedImages.clear();
    slotController.clear();
    update();
    Get.offAll(() => HomePage());
    Get.to(() => AttendancePage(attendanceIndex: 0));
  }

  void clearData(){
    selectedImages.clear();
    slotController.clear();
    update();
  }
}
