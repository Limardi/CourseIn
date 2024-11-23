import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_ss/pages/chefAI_page.dart';
import 'package:project_ss/pages/course_list.dart';
import 'package:project_ss/pages/loading_page.dart';
import 'package:project_ss/services/ai.dart';
import 'package:project_ss/services/navigation.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const Text(
              "Chef AI",
              style: TextStyle(fontSize: 30),
            ),
            const Text(
              "Cook your course",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    nav.goToFormAI();
                    //createCompletion(context);
                    //Navigator.push(context,
                    // MaterialPageRoute(builder: (context) => LoadingPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 221, 180, 212),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            const SizedBox(
              height: 120,
            ),
            const Text(
              "Course list",
              style: TextStyle(fontSize: 30),
            ),
            const Text(
              "See All Courses",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    nav.goToCourseListPage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 221, 180, 212),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
