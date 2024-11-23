import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/widgets.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/model/courses.dart';
import 'package:project_ss/model/user.dart';
import 'package:project_ss/repositories/user_repo.dart';
import 'package:project_ss/view_model/me_vm.dart';
import 'package:provider/provider.dart';
import 'package:project_ss/services/navigation.dart';

class CourseFillingPage extends StatefulWidget {
  final int semester;

  CourseFillingPage({required this.semester});

  @override
  _CourseFillingPageState createState() => _CourseFillingPageState();
}

class _CourseFillingPageState extends State<CourseFillingPage> {
  List<List<Course>> courses =
      []; // List to store entered courses for each semester
  // List<List<TextEditingController>> controllers = []; // List of controllers for each course input
  // List<List<bool>> editModes = []; // List to track the edit mode state for each course input

  // List<String> courseList = [
  //   "Course 1",
  //   "Course 2",
  //   "Course 3",
  //   "Course 4",
  //   "Course 5",
  //   "Course 6",
  //   "Course 7",
  //   "Course 8",
  //   "Course 9",
  //   "Course 10"
  // ];
  //List<Course> selectedCourseList = [];

  @override
  void initState() {
    super.initState();
    // Initialize the lists for each semester
    courses = List.generate(widget.semester, (index) => []);
    // controllers = List.generate(widget.semester, (index) => []);
    // editModes = List.generate(widget.semester, (index) => []);
  }

  @override
  void dispose() {
    // Dispose all controllers when the state is disposed
    // for (var controllerList in controllers) {
    //   for (var controller in controllerList) {
    //     controller.dispose();
    //   }
    // }
    super.dispose();
  }

  Future<void> _openFilterDialog(int semester) async {
    await FilterListDialog.display<Course>(
      context,
      listData: coursedata,
      selectedListData: courses[semester],
      height: 480,
      borderRadius: 20,
      headlineText: "Select Courses",
      searchFieldHintText: "Search Here",
      applyButtonTextStyle: const TextStyle(
        color: Colors.white,
      ),
      controlButtonTextStyle: const TextStyle(
        color: Colors.black,
      ),
      searchFieldBackgroundColor: Color.fromARGB(255, 214, 214, 214),
      applyButonTextBackgroundColor: const Color.fromARGB(255, 221, 180, 212),
      hideCloseIcon: true,
      choiceChipLabel: (item) => item!.title,
      choiceChipBuilder: (context, item, isSelected) {
        return ChoiceChip(
          //surfaceTintColor: Colors.white,
          label: Text(item.title),
          selected: isSelected!,
          onSelected: null,
          //color: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
          backgroundColor: Colors.white,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
          //disabledColor: Colors.white,
          shape: StadiumBorder(
            side: BorderSide(
              color: isSelected
                  ? const Color.fromARGB(255, 221, 180, 212)
                  : Colors.grey[300]!,
            ),
          ),
          selectedColor: const Color.fromARGB(
              255, 221, 180, 212), // Set the unselected color here
        );
      },
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (list, text) {
        if (list!.any((element) =>
            element.title.toLowerCase().contains(text.toLowerCase()))) {
          return list
              .where((element) =>
                  element.title.toLowerCase().contains(text.toLowerCase()))
              .toList();
        }
        return [];
      },
      onApplyButtonClick: (list) {
        if (list != null) {
          setState(() {
            courses[semester] = List.from(list);
          });
        }
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
  }

  // void _addNewCourse(int semesterIndex) async {
  //   await _openFilterDialog(semesterIndex);
  //   // if (selectedCourseList.isNotEmpty) {
  //   //   setState(() {
  //   //     courses[semesterIndex].addAll(selectedCourseList);
  //   //     // for (var course in selectedCourseList) {
  //   //     //   controllers[semesterIndex].add(TextEditingController(text: course.title));
  //   //     //   editModes[semesterIndex].add(false);
  //   //     // }
  //   //     selectedCourseList.clear();
  //   //   });
  //   // }
  // }

  void _removeCourse(int semesterIndex, int courseIndex) {
    setState(() {
      courses[semesterIndex].remove(courses[semesterIndex][courseIndex]);
    });
  }

  Future<void> _updateCoursesInFirestore(
      int semesterIndex, List<Course> courses) async {
    try {
      final userId = Provider.of<MeViewModel>(context, listen: false).myId;
      DocumentReference userDoc = FirebaseFirestore.instance
          .collection('apps/coursein/userCourses')
          .doc(userId);

      await userDoc.set(
        {
          'coursesTaken': {
            'semester${semesterIndex + 1}':
                courses.map((course) => course.coursenum).toList(),
          }
        },
        SetOptions(merge: true),
      );

      print(
          'Courses updated successfully in Firestore for semester ${semesterIndex + 1}');
    } catch (error) {
      print('Error updating courses in Firestore: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<NavigationService>(context, listen: false);

    final userId = Provider.of<MeViewModel>(context, listen: false).myId;
    DocumentReference userDoc = FirebaseFirestore.instance
        .collection('apps/coursein/users')
        .doc(userId);

    //print(userid);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Courses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.semester,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Semester ${index + 1}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          ...List.generate(courses[index].length,
                              (courseIndex) {
                            return _buildCourseInput(index, courseIndex);
                          }),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Color.fromARGB(255, 221, 180, 212),
                                ),
                                onPressed: () {
                                  _openFilterDialog(index);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0), // Adjust padding as needed
                    child: TextButton(
                      onPressed: () async {
                        userDoc.update({'currentsem': widget.semester});
                        for (int i = 0; i < widget.semester; i++) {
                          await _updateCoursesInFirestore(i, courses[i]);
                        }
                        nav.goToSchedulePage();
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                13.0), // Adjust the radius as needed
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 221, 180, 212)),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal:
                                    30.0)), // Increase padding inside the button
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          // backgroundColor: Color.fromARGB(255, 221, 180, 212)
                          color: Colors.white,
                          fontSize: 18.0, // Increase font size if needed
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Handle skip text press
                      // For now, show a reminder dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Reminder'),
                            content: const Text(
                                "Don't forget to complete this later"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  // Set reminder before moving to another page
                                  // print('Reminder set');
                                  Navigator.pop(context);
                                  nav.goToSchedulePage();
                                },
                                child: const Text('Okay'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Skip this section',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseInput(int semesterIndex, int courseIndex) {
    // TextEditingController controller = controllers[semesterIndex][courseIndex];
    // bool isEditable = editModes[semesterIndex][courseIndex];

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 130, 114, 156),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child:
                  //isEditable
                  // ? TextField(
                  //     controller: controller,
                  //     onChanged: (value) {
                  //       courses[semesterIndex][courseIndex] = value;
                  //     },
                  //     onSubmitted: (value) {
                  //       setState(() {
                  //         courses[semesterIndex][courseIndex] = value;
                  //         editModes[semesterIndex][courseIndex] = false;
                  //       });
                  //     },
                  //     decoration: InputDecoration(
                  //       hintText: 'Enter course name',
                  //     ),
                  //   )
                  //:
                  Text(
                courses[semesterIndex][courseIndex].title,
                style: TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.cancel),
              color: Colors.white,
              onPressed: () {
                // setState(() {
                //   // editModes[semesterIndex][courseIndex] = !isEditable;
                //   // if (!isEditable) {
                //   //   controllers[semesterIndex][courseIndex].text =
                //   //       courses[semesterIndex][courseIndex].title;
                //   // }
                //   courseList.remove(courses[semesterIndex][courseIndex].title);
                // });
                _removeCourse(semesterIndex, courseIndex);
              },
            ),
          ],
        ),
      ),
    );
  }
}
