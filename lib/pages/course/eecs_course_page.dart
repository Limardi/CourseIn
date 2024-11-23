import 'package:flutter/material.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/widgets/course_card.dart';

class eecs_course_page extends StatefulWidget {
  final String searchQuery;

  const eecs_course_page({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<eecs_course_page> createState() => eecs_course_pageState();
}

class eecs_course_pageState extends State<eecs_course_page> {
  @override
  Widget build(BuildContext context) {
    final filteredCourses = coursedata
        .where((course) =>
            course.department == "EECS" &&
            (course.title.toLowerCase().contains(widget.searchQuery.toLowerCase()) || course.coursenum.toLowerCase().contains(widget.searchQuery.toLowerCase()) || course.professor.toLowerCase().contains(widget.searchQuery.toLowerCase()))).toList();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: filteredCourses.length,
      itemBuilder: (context, index) {
        final course = filteredCourses[index];
        return CourseCard(
          courseName: course.title,
          courseCode: course.coursenum,
          professorName: course.professor,
          averageGPA: course.lastGPA,
          rating: course.rating,
          details: course.details,
          time: course.time,
          creds: course.creds,
        );
      },
    );
  }
}
