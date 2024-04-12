import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mark_it/controllers/home_page_controller.dart';
import 'package:mark_it/presentation/util/person_card.dart';

import 'image_screen.dart';

class AttendancePage extends StatelessWidget {
  final int attendanceIndex;
  const AttendancePage({super.key, required this.attendanceIndex});

  @override
  Widget build(BuildContext context) {
    TextEditingController regNoController = TextEditingController();
    HomePageController homePageController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(homePageController.attendance[attendanceIndex].slot),
            SizedBox(width: 20,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xff0d51ad),
              ),
              child: Text(homePageController.attendance[attendanceIndex].date,style: TextStyle(fontSize: 15),),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () {
              Get.to(() => ImageScreen(imageUrls: homePageController.attendance[attendanceIndex].images));
            }, ),
          SizedBox(width: 10,),
        ],
      ),
      body: GetBuilder<HomePageController>(
        builder: (controller){
          return Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: homePageController.attendance[attendanceIndex].attendees.isEmpty ?
            Center(child: Text('No attendees',style: TextStyle(fontSize: 20),),) :
            ListView.builder(itemBuilder: (context, index){
              return PersonCard(
                regNo: homePageController.attendance[attendanceIndex].attendees[index],
                docId: homePageController.attendance[attendanceIndex].id,
              );
            },
              itemCount: homePageController.attendance[attendanceIndex].attendees.length,
              shrinkWrap: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF2B3871),
        onPressed: (){
          Get.defaultDialog(
            title: 'Add Attendee',
            titlePadding: EdgeInsets.only(top: 20),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
              child: TextField(
                controller: regNoController,
                decoration: InputDecoration(
                  hintText: 'Enter Registration Number',
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  if (regNoController.text == ''){
                    Get.snackbar('Error', 'Please enter registration number');
                    return;
                  }
                  homePageController.addAttendee(homePageController.attendance[attendanceIndex].id, regNoController.text);
                  regNoController.text = '';
                  Get.back();
                },
                child: Text('Add', style: TextStyle(
                    color: Color(0xFF8196E8)
                ),),
              ),
            ],
          );
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }
}


