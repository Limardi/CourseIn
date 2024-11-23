import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/model/courses.dart';
import 'package:project_ss/services/ai.dart';
import 'package:project_ss/view_model/me_vm.dart';
import 'package:provider/provider.dart';

class chefAI_page extends StatefulWidget {
  const chefAI_page({super.key});

  @override
  State<chefAI_page> createState() => _chefAI_pageState();
}

class _chefAI_pageState extends State<chefAI_page> {
  final TextEditingController _creditsController = TextEditingController();
  final TextEditingController _semesterchosen = TextEditingController();
  final _form1 = GlobalKey<FormState>();
  final _form2 = GlobalKey<FormState>();
  var credits = '';
  var semester = '';
  int page = 1;
  List<List<Course>> courses = [];
  List<String> taken = [];
  int currentsem = 0;
  int counter = 0;
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
              //taken[sem - 1] = '$courseNums';
              print('Semester $sem: $courseNums');
            }
          }
        }
      }
      print(courses);
    } catch (error) {
      print('Error fetching courses for semester $sem: $error');
    }
  }

  void createString() {
    int counter = 0;
    for (var i in courses) {
      for (var j in i) {
        taken.insert(0, j.title);
      }
    }
    String res = taken.join(", ");
    print(res);
  }

  Widget page1() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "How many core credits do you want to take?",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8.0), // Space between text and input field
            SizedBox(
                width: 60.0, // Fixed width for the input field
                height: 40.0,
                child: Form(
                  key: _form1,
                  child: TextFormField(
                    key: const ValueKey('credits'),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                    onSaved: (value) {
                      credits = value!;
                    },
                  ),
                )),
            const SizedBox(
                height: 32.0), // Space between input field and button
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  _form1.currentState!.save();
                  setState(() {
                    page = 2;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 221, 180, 212),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 40,
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget page2() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Which semester course do u want to generate?",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8.0), // Space between text and input field
            SizedBox(
                width: 60.0, // Fixed width for the input field
                height: 40.0,
                child: Form(
                  key: _form2,
                  child: TextFormField(
                    key: const ValueKey('semester'),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                    onSaved: (value) {
                      semester = value!;
                    },
                    validator: (value) {
                      print(semester);
                      int sem = int.parse(semester);
                      print(sem);
                      if (sem < 1 || sem > 8) {
                        return 'invalid !!';
                      }
                      return null;
                    },
                  ),
                )),
            const SizedBox(
                height: 32.0), // Space between input field and button
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  _form2.currentState!.save();
                  final isvalid = _form2.currentState!.validate();
                  if (!isvalid) {
                    return;
                  }
                  setState(() {
                    page = 3;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 221, 180, 212),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 40,
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget page3() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$credits core credits on semester $semester  ? ",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
                height: 64.0), // Space between input field and button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  //createString();
                  createCompletion(context, credits, semester, courses);
                  // Add your onPressed logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 221, 180, 212),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 40,
                  ),
                ),
                child: const Text(
                  "Generate Course",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chef AI",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: page == 1
          ? page1()
          : page == 2
              ? page2()
              : page3(), // Change to page2() if you want to display page2
    );
  }
}
