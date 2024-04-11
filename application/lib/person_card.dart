import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Container(
        child: Row(
          children: [
            Expanded(child: Text('Person 1',
            style: TextStyle(fontSize: 17),)),
            SizedBox(width: 40,),
            IconButton(onPressed: null, icon: Icon(Icons.delete),
            iconSize: 35,),
          ],
        ),
      ),
    );
  }
}