import 'package:flutter/material.dart';

import 'date_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Marked')),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    DateCard(),
                    DateCard(),
                    DateCard(),
                    DateCard(),
                    DateCard(),
                    DateCard(),
                    DateCard(),
                  ],
                )
              ),
            ],
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

