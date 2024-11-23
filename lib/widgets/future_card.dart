import 'package:flutter/material.dart';

class FutureCard extends StatelessWidget {
  final String jobName;
  final String relatedCourse;
  final String jobOpportunities;
  const FutureCard({
    required this.jobName,
    required this.jobOpportunities,
    required this.relatedCourse,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Optional: You can adjust the radius of the border
        side: BorderSide(color: const Color.fromARGB(255, 0, 0, 0), width: 1.0), // Adjust the color and width of the border
      ),
      color: Color.fromARGB(255, 255, 255, 255),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  jobName,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Related Courses: $relatedCourse',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ), // Smaller font for professor name
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Job Opportunities: $jobOpportunities',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ), // Smaller font for average GPA
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
