import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/model/courses.dart';
import 'package:project_ss/view_model/me_vm.dart';
import 'package:project_ss/widgets/schedule_card.dart';
import 'package:project_ss/services/navigation.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({super.key, required this.day});
  int day;
  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void didChangeDependencies() {
    _fetchSemester();
    _fetchCourses();
// your codes
  }

  List<Course> currentSemesterCourses = [];
  int currentsem = 0;
  void initState() {
    super.initState();
    for (var i in thisSem) {
    for (var j in i) {
      j.content = '';
    }
  }
  currentsem = 0;
  check = [false, false, false, false, false, false, false];

    // Initialize the lists for each semester
    _fetchSemester();
    _fetchCourses();
  }

  void _updateThis() {
    print(currentSemesterCourses);
    //print('d');
    print(currentsem);
    for (var i in currentSemesterCourses) {
      for (var j in i.sched) {
        print(j);
        switch (j[0]) {
          case 'M':
            {
              check[0] = true;
              if ("a" == j[1]) {
                thisSem[0][10].content = i.title;
              } else if ("b" == j[1]) {
                thisSem[0][11].content = i.title;
              } else if ("c" == j[1]) {
                thisSem[0][12].content = i.title;
              } else {
                thisSem[0][int.parse(j[1])].content = i.title;
              }
            }
            break;
          case 'T':
            {
              check[1] = true;
              if ("a" == j[1]) {
                thisSem[1][10].content = i.title;
              } else if ("b" == j[1]) {
                thisSem[1][11].content = i.title;
              } else if ("c" == j[1]) {
                thisSem[1][12].content = i.title;
              } else {
                thisSem[1][int.parse(j[1])].content = i.title;
              }
            }
            break;
          case 'W':
            {
              check[2] = true;
              if ("a" == j[1]) {
                thisSem[2][10].content = i.title;
              } else if ("b" == j[1]) {
                thisSem[2][11].content = i.title;
              } else if ("c" == j[1]) {
                thisSem[2][12].content = i.title;
              } else {
                thisSem[2][int.parse(j[1])].content = i.title;
              }
            }
            break;
          case 'R':
            {
              check[3] = true;
              if ("a" == j[1]) {
                thisSem[3][10].content = i.title;
              } else if ("b" == j[1]) {
                thisSem[3][11].content = i.title;
              } else if ("c" == j[1]) {
                thisSem[3][12].content = i.title;
              } else {
                thisSem[3][int.parse(j[1])].content = i.title;
              }
            }
            break;
          case 'F':
            {
              check[4] = true;
              if ("a" == j[1]) {
                thisSem[4][10].content = i.title;
              } else if ("b" == j[1]) {
                thisSem[4][11].content = i.title;
              } else if ("c" == j[1]) {
                thisSem[4][12].content = i.title;
              } else {
                thisSem[4][int.parse(j[1])].content = i.title;
              }
            }
            break;
          case 'S':
            {
              check[5] = true;
              if ("a" == j[1]) {
                thisSem[5][10].content = i.title;
              } else if ("b" == j[1]) {
                thisSem[5][11].content = i.title;
              } else if ("c" == j[1]) {
                thisSem[5][12].content = i.title;
              } else {
                thisSem[5][int.parse(j[1])].content = i.title;
              }
            }
            break;
        }
      }
    }
  }

  Future<void> _fetchSemester() async {
    final userId = Provider.of<MeViewModel>(context, listen: false).myId;
    final userDoc = FirebaseFirestore.instance
        .collection('apps/coursein/users')
        .doc(userId);

    DocumentSnapshot docSnapshot = await userDoc.get();
    currentsem = docSnapshot.get('currentsem');

    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    try {
      final userId = Provider.of<MeViewModel>(context, listen: false).myId;
      final userDoc = FirebaseFirestore.instance
          .collection('apps/coursein/userCourses')
          .doc(userId);

      DocumentSnapshot docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          Map<String, dynamic>? coursesTaken =
              data['coursesTaken'] as Map<String, dynamic>?;
          if (coursesTaken != null) {
            setState(() {
              String semesterKey = 'semester$currentsem';
              if (coursesTaken.containsKey(semesterKey)) {
                print(semesterKey);
                List<dynamic> courseNums =
                    coursesTaken[semesterKey] as List<dynamic>;
                currentSemesterCourses = courseNums
                    .map((num) => coursedata
                        .firstWhere((course) => course.coursenum == num))
                    .toList();
                print(courseNums);
              }
              else{
                currentSemesterCourses = [];
              }
            });
          }
        }
      }
    } catch (error) {
      print('Error fetching courses from Firestore: $error');
    }
    _updateThis();
  }

  Widget build(BuildContext context) {
    List<Widget> days = [
      Text(
        'Monday',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      Text(
        'Tuesday',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      Text(
        'Wednesday',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      Text(
        'Thursday',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      Text(
        'Friday',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      Text(
        'Saturday',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      Text(
        'Sunday',
        style: Theme.of(context).textTheme.titleLarge,
      )
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Your Current Semester Schedule',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 221, 180, 212),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 40,
                    onPressed: () {
                      this.setState(() {
                        if (widget.day == 0) {
                          widget.day = 6; 
                        } else
                          widget.day -= 1;
                        print(widget.day);
                      });
                      _fetchSemester();
                      _fetchCourses();
                    },
                    icon: Icon(Icons.arrow_left),
                    padding: EdgeInsets.all(0.0),
                  ),
                  days[widget.day],
                  IconButton(
                    iconSize: 40,
                    onPressed: () {
                      this.setState(() {
                        if (widget.day == 6)
                          widget.day = 0;
                        else
                          widget.day += 1;
                      });
                      _fetchSemester();
                      _fetchCourses();
                      print(widget.day);
                    },
                    icon: Icon(Icons.arrow_right),
                    padding: EdgeInsets.all(0.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        if (!check[widget.day])
          Text(
            'No Courses',
            style: TextStyle(
                color: Color.fromARGB(255, 80, 56, 56),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        if (check[widget.day])
          for (var i in thisSem[widget.day])
            if (i.content != '') ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: ScheduleCard(
                  height: 50,
                  width: 500,
                  title: i.title,
                  content: i.content,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
        Spacer(),
      ],
    );
  }
}
