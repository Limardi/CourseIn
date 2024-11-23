import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/model/courses.dart';
import 'package:project_ss/pages/course/semester_page.dart';
import 'package:project_ss/services/navigation.dart';
import 'package:project_ss/view_model/me_vm.dart';
import 'package:provider/provider.dart';

class TakenCoursesPage extends StatefulWidget {
  @override
  State<TakenCoursesPage> createState() => _TakenCoursesPageState();
}

class _TakenCoursesPageState extends State<TakenCoursesPage> {
  final List<String> semesters = [
    '1st Semester',
    '2nd Semester',
    '3rd Semester',
    '4th Semester',
    '5th Semester',
    '6th Semester',
    '7th Semester',
    '8th Semester',
  ];

  final List<String> details = [
    'Fall semester',
    'Spring semester',
    'Fall semester',
    'Spring semester',
    'Fall semester',
    'Spring semester',
    'Fall semester',
    'Spring semester',
  ];

  @override
  List<List<Course>> courses = [];
  int currentsem = 0;

  @override
  void initState() {
    super.initState();
    _fetchSemester();
  }

  Future<void> _fetchSemester() async {
    final userId = Provider.of<MeViewModel>(context, listen: false).myId;
    final userDoc = FirebaseFirestore.instance
        .collection('apps/coursein/users')
        .doc(userId);

    try {
      DocumentSnapshot docSnapshot = await userDoc.get();
      currentsem = docSnapshot.get('currentsem');

      // Initialize the courses list with empty lists for each semester
      courses = List.generate(currentsem, (index) => []);

      for (int i = 1; i <= currentsem; i++) {
        await _fetchCourses(i);
      }

      setState(() {});
    } catch (error) {
      print('Error fetching semester data: $error');
    }
  }

  Future<void> _fetchCourses(int sem) async {
    final userId = Provider.of<MeViewModel>(context, listen: false).myId;
    final userDoc = FirebaseFirestore.instance
        .collection('apps/coursein/userCourses')
        .doc(userId);

    try {
      DocumentSnapshot docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          Map<String, dynamic>? coursesTaken =
              data['coursesTaken'] as Map<String, dynamic>?;
          if (coursesTaken != null) {
            String semesterKey = 'semester$sem';
            if (coursesTaken.containsKey(semesterKey)) {
              List<dynamic> courseNums =
                  coursesTaken[semesterKey] as List<dynamic>;
              setState(() {
                courses[sem - 1] = courseNums
                    .map((num) => coursedata
                        .firstWhere((course) => course.coursenum == num))
                    .toList();
              });
              print('Semester $sem: $courseNums');
            }
          }
        }
      }
    } catch (error) {
      print('Error fetching courses for semester $sem: $error');
    }
  }

  Widget build(BuildContext context) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Taken Courses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.0),
        itemCount: currentsem,
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(height: 16),
        itemBuilder: (BuildContext context, int index) {
          final course = courses[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SemesterPage(
                    semester: 'Semester ${index + 1}',
                    details: details[index],
                    courses: course,
                    sem: index + 1,
                  ),
                ),
              );
            },
            child: _buildCourseCard(semesters[index], details[index]),
          );
        },
      ),
    );
  }

  Widget _buildCourseCard(String semester, String details) {
    return Card(
      color: Color.fromARGB(255, 130, 114, 156),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              semester,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(details, style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
