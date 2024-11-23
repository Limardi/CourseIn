import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_ss/model/courses.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/view_model/me_vm.dart';
import 'package:project_ss/widgets/course_card.dart';
import 'package:provider/provider.dart';

class SemesterPage extends StatefulWidget {
  final String semester;
  final String details;
  List<Course> courses;
  final int sem;

  SemesterPage(
      {required this.semester,
      required this.details,
      required this.courses,
      required this.sem});

  @override
  _SemesterPageState createState() => _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage> {
  //List<Course> _selectedCourses = [];

  void _addCourse(Course course) {
    setState(() {
      widget.courses.add(course);
    });
  }

  void _removeCourse(int index) {
    setState(() {
      widget.courses.removeAt(index);
    });
  }

  void _showCourseSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CourseSearchDialog(
          onSelectCourse: _addCourse,
        );
      },
    );
  }

  Future<void> _updatedb() async {
    try {
      final userId = Provider.of<MeViewModel>(context, listen: false).myId;
      final userDoc = FirebaseFirestore.instance
          .collection('apps/coursein/userCourses')
          .doc(userId);

      await userDoc.set({
        'coursesTaken': {
          'semester${widget.sem}':
              widget.courses.map((course) => course.coursenum).toList(),
        }
      }, SetOptions(merge: true));
      print(
          'Courses updated successfully in Firestore for semester ${widget.semester}');
    } catch (error) {
      print('Error updating courses in Firestore: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.semester} Details'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showCourseSearchDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.courses.length,
                itemBuilder: (context, index) {
                  final course = widget.courses[index];
                  return CourseCard(
                    courseName: course.title,
                    courseCode: course.coursenum,
                    professorName: course.professor,
                    averageGPA: course.lastGPA,
                    rating: course.rating,
                    details: course.details,
                    time: course.time,
                    creds: course.creds,
                    onDelete: () =>
                        _removeCourse(index), // Pass the delete function
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TextButton(
                    onPressed: () {
                      _updatedb();
                      Navigator.of(context).pop();
                      check = [false, false, false, false, false, false, false];
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              100), // Adjust the radius as needed
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 221, 180, 212)),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        // backgroundColor: Color.fromARGB(255, 221, 180, 212)
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CourseSearchDialog extends StatefulWidget {
  final Function(Course) onSelectCourse;

  CourseSearchDialog({required this.onSelectCourse});

  @override
  _CourseSearchDialogState createState() => _CourseSearchDialogState();
}

class _CourseSearchDialogState extends State<CourseSearchDialog> {
  List<Course> _searchResults = coursedata;
  String _searchQuery = '';

  void _searchCourses(String query) {
    setState(() {
      _searchQuery = query;
      _searchResults = coursedata
          .where((course) =>
              course.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Search Courses'),
      surfaceTintColor: Colors.white,
      content: SizedBox(
        height: 300, // Fixed height for the dialog content
        width: double.maxFinite, // Ensure it takes the available width

        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Search'),
              onChanged: _searchCourses,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final course = _searchResults[index];
                  return ListTile(
                    title: Text(course.title),
                    subtitle: Text(course.professor),
                    onTap: () {
                      widget.onSelectCourse(course);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 221, 180, 212)),
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
