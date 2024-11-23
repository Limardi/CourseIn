import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key, required this.currentIndex});
  int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            DrawerHeader(
                child: Center(
              child: Text(
                'CourseIn',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            )),
            ListTile(
              title: Center(child: Text("hello")),
              onTap: () => {
                print("tapeed"),
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListTile(
                dense: true,
                tileColor: Colors.amber,
                title: Center(child: Text("Assignment")),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onTap: () => {
                  print("ADIUSDA"),
                },
              ),
            ),
            ListTile(
              title: Center(child: Text("Academic Calendar")),
              onTap: () => {
                print("AC"),
              },
            )
          ],
        ),
      ),
    );
  }
}
