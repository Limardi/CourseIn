import 'package:flutter/material.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/pages/auth/authentication.dart';
import 'package:project_ss/pages/course_page.dart';
import 'package:project_ss/pages/future_page.dart';
import 'package:project_ss/pages/schedule_page.dart';
import 'package:project_ss/pages/auth/sign_up.dart';
import 'package:project_ss/services/fetch.dart';
import 'package:project_ss/services/navigation.dart';
import 'package:project_ss/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:project_ss/widgets/Profile_page.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key, required this.currentIndex});
  int currentIndex;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> body = [
    SchedulePage(
      day: 0,
    ),
    CoursePage(),
    FuturePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              iconSize: 40,
              onPressed: () async{
                for (var i in thisSem) {
    for (var j in i) {
      j.content = '';
    }
  }
  currentsem = 0;
  check = [false, false, false, false, false, false, false];
                Provider.of<AuthenticationService>(context, listen: false)
                    .logOut();
              },
              icon: Icon(Icons.logout)),
          Spacer(),
          IconButton(
              iconSize: 40,
              onPressed: () {
                for (var i in thisSem) {
                  for (var j in i) {
                    j.content = '';
                  }
                }
                check = [false, false, false, false, false, false, false];
                goToProfile(context);
              },
              icon: Icon(Icons.person)),
        ],
      ),
      //drawer: DrawerWidget(currentIndex: 0),
      body: Center(
        child: body[widget.currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (int newIndex) {
          setState(() {
            updateRoute(newIndex, context);
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: 'Schedule', icon: Icon(Icons.access_alarm)),
          BottomNavigationBarItem(
              label: 'Course', icon: Icon(Icons.accessibility)),
          BottomNavigationBarItem(
              label: 'Future', icon: Icon(Icons.account_balance)),
        ],
      ),
    );
  }
}

void updateRoute(int index, BuildContext context) {
  final nav = Provider.of<NavigationService>(context, listen: false);
  switch (index) {
    case 0:
      nav.goToSchedulePage();
      return;
    case 1:
      nav.goToCoursePage();
      return;
    case 2:
      nav.goToFuturePage();
      return;
  }
}

void goToProfile(BuildContext context) {
  final nav = Provider.of<NavigationService>(context, listen: false);
  nav.pushProfileOnTab(context: context);
}
