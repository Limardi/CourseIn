import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/view_model/me_vm.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:assistant_openai/openaiassistant.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/services/navigation.dart';
import 'package:provider/provider.dart';

void updateThis() {
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

Future<void> fetchSemester(BuildContext context) async {
  final userId = Provider.of<MeViewModel>(context, listen: false).myId;
  final userDoc =
      FirebaseFirestore.instance.collection('apps/coursein/users').doc(userId);

  DocumentSnapshot docSnapshot = await userDoc.get();
  currentsem = docSnapshot.get('currentsem');

  fetchCourses(context);
}

Future<void> fetchCourses(BuildContext context) async {
  try {
    final userId = Provider.of<MeViewModel>(context, listen: false).myId;
    final userDoc = FirebaseFirestore.instance
        .collection('apps/coursein/userCourses')
        .doc(userId);

    DocumentSnapshot docSnapshot = await userDoc.get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        Map<String, dynamic>? coursesTaken =
            data['coursesTaken'] as Map<String, dynamic>?;
        if (coursesTaken != null) {
          String semesterKey = 'semester$currentsem';
          if (coursesTaken.containsKey(semesterKey)) {
            print(semesterKey);
            List<dynamic> courseNums =
                coursesTaken[semesterKey] as List<dynamic>;
            currentSemesterCourses = courseNums
                .map((num) =>
                    coursedata.firstWhere((course) => course.coursenum == num))
                .toList();
            print(courseNums);
          }
        }
      }
    }
  } catch (error) {
    print('Error fetching courses from Firestore: $error');
  }
  updateThis();
}

void clearData() {
  for (var i in thisSem) {
    for (var j in i) {
      j.content = '';
    }
  }
  currentsem = 0;
  check = [false, false, false, false, false, false, false];
}
