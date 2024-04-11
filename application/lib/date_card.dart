import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  const DateCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: InkWell(
        child: Container(
          height: 50,
          child: const Center(child: Text('Entry A')),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xFF4d7dc6),
          ),
        ),
        onTap: (){
          Navigator.pushNamed(context, '/Attendance', );
        },
      ),
    );
  }
}
