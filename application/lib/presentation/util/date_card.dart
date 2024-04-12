import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/attendance_page.dart';

class DateCard extends StatelessWidget {
  final String time;
  final String date;
  final String slot;
  final int attendanceIndex;
  const DateCard({
    super.key, required this.time, required this.slot, required this.date, required this.attendanceIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: InkWell(
        onTap: (){
          Get.to(() => AttendancePage(attendanceIndex: attendanceIndex));
        },
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(date),
              Text(time),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black,
                  ),
                  child: Text(slot)
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xff0d51ad),
          ),
        ),
      ),
    );
  }
}
