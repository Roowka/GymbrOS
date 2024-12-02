import 'package:flutter/material.dart';
import 'package:gymbros/src/shared/utils/constants.dart';
import 'package:gymbros/src/shared/widget/custom_history_title.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Start Strong and Set Your Fitness Goals',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle start exercise
                    },
                    child: Text('Start Exercise'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      backgroundColor: Colors.white, // Button text color
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Text('Workout History',
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            const CustomHistoryTitle(
              workoutDate: 'Oct 10, 2024',
              workoutType: 'Full Body',
              workoutDuration: '22 Min',
            ),
            const CustomHistoryTitle(
              workoutDate: 'Oct 8, 2024',
              workoutType: 'Upper Body',
              workoutDuration: '18 Min',
            ),
            const CustomHistoryTitle(
              workoutDate: 'Oct 5, 2024',
              workoutType: 'Cardio Session',
              workoutDuration: '30 Min',
            ),
          ],
        ),
      ),
    );
  }
}
