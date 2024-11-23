import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_ss/pages/course/all_course_page.dart';
import 'package:project_ss/pages/course/cs_course_page.dart';
import 'package:project_ss/pages/course/eecs_course_page.dart';
import 'package:project_ss/widgets/text_form.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = searchController.text;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Course List',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(120),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Image.asset(
                        'lib/assets/search.png',
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TabBar(
                    dividerColor: Colors.transparent,
                    physics: const NeverScrollableScrollPhysics(),
                    indicator: ShapeDecoration(
                      color: const Color.fromARGB(255, 224, 214, 222),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    tabs: [
                      TextButton(
                        onPressed: () {
                          _tabController.animateTo(0);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            shadowColor: Colors.white),
                        child: const Text(
                          'All',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _tabController.animateTo(1);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        child: const Text(
                          'CS',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _tabController.animateTo(2);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        child: const Text(
                          'EECS',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          all_course_page(searchQuery: searchQuery),
          cs_course_page(searchQuery: searchQuery),
          eecs_course_page(searchQuery: searchQuery),
        ],
      ),
    );
  }
}
