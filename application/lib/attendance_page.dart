import 'package:flutter/material.dart';
import 'package:mark_it/person_card.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              iconSize: 40,
              onPressed: () { Navigator.pushNamed(context, '/HomePage', ); }, ),
          ),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
            child: Text('Date',
              style: TextStyle(
                fontSize: 30,
              ),),
          ),
          actions: [Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
            child: IconButton(
              icon: Icon(Icons.image),
              iconSize: 40,
              onPressed: () {  }, ),
          ),],
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
              //       child: IconButton(
              //         icon: Icon(Icons.arrow_back_outlined),
              //         iconSize: 40,
              //         onPressed: () { Navigator.pushNamed(context, '/HomePage', ); }, ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
              //       child: Text('Date',
              //         style: TextStyle(
              //           fontSize: 30,
              //         ),),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
              //       child: IconButton(
              //         icon: Icon(Icons.image),
              //         iconSize: 40,
              //         onPressed: () {  }, ),
              //     ),
              //   ],
              // ),
              ListView(
                shrinkWrap: true,
                children: [
                  PersonCard(),
                  PersonCard(),
                  PersonCard(),
                  PersonCard(),
                ],
              )
            ],
          ),
        ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Color(0xFF2B3871),
            onPressed: (){},
            label: const Text('Add'),
            icon: const Icon(Icons.add, color: Colors.white, size: 25),
          ),
      ),
    );
  }
}


