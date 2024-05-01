import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mark_it/controllers/home_page_controller.dart';

class PersonCard extends StatelessWidget {
  final String regNo;
  final String docId;
  const PersonCard({
    super.key, required this.regNo, required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.find();
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFF4d7dc6).withOpacity(0.3),
      ),
      child: Row(
        children: [
          Expanded(child: Text(regNo,
            style: TextStyle(fontSize: 17),)),
          SizedBox(width: 40,),
          IconButton(onPressed: (){
            homePageController.deleteAttendee(docId, regNo);
          }, icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}