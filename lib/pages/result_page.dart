import 'package:flutter/material.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/widgets/course_card.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    String sem = '1st';
    switch (generateSemester) {
      case 1:
        {
          sem = '1st';
        }
        break;
      case 2:
        {
          sem = '2nd';
        }
        break;
      default:
        {
          sem = '$generateSemester' + 'rd';
        }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(sem + ' Semester'),
      ),
      body: Center(
        child: Column(
          children: [
            for (var course in coursedata) ...[
              for (var j in courseNums)
                if (course.coursenum == j) ...[
                  CourseCard(
                    courseName: course.title,
                    courseCode: course.coursenum,
                    professorName: course.professor,
                    averageGPA: course.lastGPA,
                    rating: course.rating,
                    details: course.details,
                    time: course.time,
                    creds: course.creds,
                  )
                ]
            ],
          ],
        ),
      ),
    );
  }
}
