import 'package:flutter/material.dart';
import 'package:mark_it/controllers/add_attendance_controller.dart';
import 'package:mark_it/controllers/home_page_controller.dart';
import 'package:get/get.dart';
import 'package:mark_it/presentation/screens/add_attendance_page.dart';
import '../util/date_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.put(HomePageController());

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Marked')),
      ),
      body: GetBuilder(
        init: homePageController,
        builder: (HomePageController controller){
          return ListView.builder(itemBuilder: (context, index){
            return DateCard(
              attendanceIndex: index,
              date: homePageController.attendance[index].date,
              time: homePageController.attendance[index].time,
              slot: homePageController.attendance[index].slot,
            );
          },
            itemCount: homePageController.attendance.length,
            shrinkWrap: true,
          );
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF2B3871),
        onPressed: (){
          Get.to(() => ImagePickerScreen());
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }
}

