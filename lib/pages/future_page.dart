import 'package:flutter/material.dart';
import 'package:project_ss/pages/topology_page.dart';
import 'package:project_ss/pages/futureplanning_page.dart';
import 'package:project_ss/services/navigation.dart';
import 'package:provider/provider.dart';

class FuturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Topology",
          style: TextStyle(fontSize: 30),
        ),
        const Text(
          "Check the Courses Topology",
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
                nav.goToTopologyPage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 221, 180, 212),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
        const SizedBox(
          height: 120,
        ),
        const Text(
          "Future Planning",
          style: TextStyle(fontSize: 30),
        ),
        const Text(
          "Plan for Future Job applications",
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
                nav.goToFuturePlanningPage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 221, 180, 212),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ))
      ],
    );
  }
}
