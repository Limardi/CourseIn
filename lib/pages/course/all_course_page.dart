import 'package:flutter/material.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/widgets/course_card.dart';

class all_course_page extends StatefulWidget {
  final String searchQuery;

  all_course_page({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<all_course_page> createState() => all_course_pageState();
}

class all_course_pageState extends State<all_course_page> {
  @override
  Widget build(BuildContext context) {
    final filteredCourses = coursedata.where((course) {
      final query = widget.searchQuery.toLowerCase();
      return course.title.toLowerCase().contains(query) || course.coursenum.toLowerCase().contains(query) || course.professor.toLowerCase().contains(query);}).toList();

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
