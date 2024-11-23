import 'package:flutter/material.dart';
import 'package:project_ss/pages/course_details.dart'; // Adjust the import path accordingly

class CourseCard extends StatelessWidget {
  final String courseName;
  final String courseCode;
  final String professorName;
  final double averageGPA;
  final double rating;
  final String details;
  final String time;
  final int creds;
  final VoidCallback? onDelete;

  const CourseCard({
    required this.courseName,
    required this.courseCode,
    required this.professorName,
    required this.averageGPA,
    required this.rating,
    required this.details,
    required this.time,
    required this.creds,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(
              courseName: courseName,
              courseCode: courseCode,
              professorName: professorName,
              averageGPA: averageGPA,
              rating: rating,
              details: details,
              time: time,
              creds: creds,
            ),
          ),
        );
      },
      child: Card(
        color: Color.fromARGB(255, 130, 114, 156),
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      courseName,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                  if (onDelete !=
                      null) // Show delete icon if onDelete is provided
                    IconButton(
                      icon: Icon(Icons.cancel,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      onPressed: onDelete,
                    ),
                ],
              ),
              const SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Professor: $professorName',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ), // Smaller font for professor name
                  ),
                  Row(
                    children: [
                      Text(
                        'Average GPA: $averageGPA',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ), // Smaller font for average GPA
                      ),
                      Spacer(),
                      Text(
                        courseCode,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ), // Smaller font for course code
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
