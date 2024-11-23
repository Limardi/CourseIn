import 'package:flutter/material.dart';
import 'package:project_ss/pages/taken_courses_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:project_ss/view_model/me_vm.dart';
import 'package:project_ss/services/navigation.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentsem = 0;
  String email = '';
  String studentid = '';
  String selectedSemester = '1st Semester';

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

    DocumentSnapshot docSnapshot = await userDoc.get();
    setState(() {
      email = docSnapshot.get('email');
      studentid = docSnapshot.get('studentid');
      currentsem = docSnapshot.get('currentsem');
      selectedSemester =
          semesters[currentsem - 1]; // Adjust index to match the list
    });
  }

  final TextEditingController _fieldOfInterestController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(studentid, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            SizedBox(
              width: 200, // Fixed width for the text field
              child: TextField(
                controller: TextEditingController(text: email),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'e-mail',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                ),
                readOnly: true,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200, // Fixed width for the dropdown
              child: DropdownButtonFormField<String>(
                value: selectedSemester,
                icon: const Icon(Icons.arrow_drop_down),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    final semesterNumber = int.parse(newValue.split(' ')[0][0]);
                    final userId =
                        Provider.of<MeViewModel>(context, listen: false).myId;
                    final userDoc = FirebaseFirestore.instance
                        .collection('apps/coursein/users')
                        .doc(userId);

                    userDoc.update({'currentsem': semesterNumber});
                    print('current sem : $semesterNumber');
                    setState(() {
                      selectedSemester = newValue;
                      currentsem = semesterNumber;
                    });
                  }
                },
                items: semesters.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200, // Fixed width for buttons
              child: InkWell(
                onTap: () {
                  nav.goToCourseTaken(context: context);
                },
                child: const InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  child: Text(
                    'Taken Courses',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
