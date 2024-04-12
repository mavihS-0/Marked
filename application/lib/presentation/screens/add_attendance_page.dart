import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:mark_it/controllers/add_attendance_controller.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {

  AddAttendanceController addAttendanceController = Get.put(AddAttendanceController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addAttendanceController.pickImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              addAttendanceController.pickImages();
            },
          ),
          SizedBox(width: 10,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<AddAttendanceController>(
          builder: (controller){
            return  GridView.builder(
              itemCount: addAttendanceController.selectedImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 8.0, // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.dialog(
                      Stack(
                        children: [
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                color: Colors.black.withOpacity(0.5), // Adjust the opacity of the background
                              ),
                            ),
                          ),
                          // Dialog content
                          Center(
                            child: Dialog(
                              child: TapRegion(
                                onTapOutside: (event){
                                  Get.back();
                                },
                                child: Image.file(
                                  File(addAttendanceController.selectedImages[index]
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Image.file(
                    File(addAttendanceController.selectedImages[index]),
                  ),
                );
              },
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF2B3871),
        onPressed: (){
          Get.defaultDialog(
            titlePadding: EdgeInsets.only(top: 20),
            title: 'Add Attendance',
            content: Column(
              children: [
                IconButton(onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: Get.overlayContext!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    addAttendanceController.date.value = picked.day.toString() + '/' + picked.month.toString() + '/' + picked.year.toString();
                  }
                }, icon: Icon(Icons.calendar_month)),
                Obx(() => Text('Date : ' + addAttendanceController.date.value)),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                  child: TextField(
                    controller: addAttendanceController.slotController,
                    decoration: InputDecoration(
                      hintText: 'Enter Slot',
                    ),
                  ),
                ),
              ],
            ),
            confirm: GetBuilder<AddAttendanceController>(builder: (controller){
              return ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context)=> const Center(child: CircularProgressIndicator(),)
                  );
                  await addAttendanceController.addAttendanceData();
                },
                child: Text('Confirm', style: TextStyle(
                    color: Color(0xFF8196E8)
                ),),
              );
            }),
            cancel: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel', style: TextStyle(
                color: Color(0xFF8196E8)
              ),),
            ),
          );
        },
        label: const Text('Done'),
        icon: const Icon(Icons.check, color: Colors.white, size: 25),
      ),
    );
  }
}