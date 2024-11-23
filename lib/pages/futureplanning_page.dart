import 'package:flutter/material.dart';
import 'package:project_ss/pages/news_details_page.dart';
import 'package:project_ss/pages/plan/future.dart';
import 'package:project_ss/pages/plan/news.dart';

class FuturePlanningPage extends StatefulWidget {
  @override
  _FuturePlanningPageState createState() => _FuturePlanningPageState();
}

class _FuturePlanningPageState extends State<FuturePlanningPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text('Future Planning',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Column(
                children: [
                  TabBar(
                    dividerColor: Colors.transparent,
                    physics: NeverScrollableScrollPhysics(),
                    indicator: ShapeDecoration(
                      color: Color.fromARGB(255, 224, 214, 222),
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
                        child: Text(
                          'Info',
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
                        child: Text(
                          'News',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          FutureInfo(),
          NewsInfo(),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
