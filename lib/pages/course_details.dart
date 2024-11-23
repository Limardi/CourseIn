import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/pages/AI_detail.dart';
import 'package:project_ss/services/ai.dart';
import 'package:project_ss/services/navigation.dart';
import 'package:provider/provider.dart';

class CourseDetailPage extends StatefulWidget {
  final String courseName;
  final String courseCode;
  final String professorName;
  final double averageGPA;
  final double rating;
  final String details;
  final String time;
  final int creds;

  const CourseDetailPage({
    Key? key,
    required this.courseName,
    required this.courseCode,
    required this.professorName,
    required this.averageGPA,
    required this.rating,
    required this.details,
    required this.time,
    required this.creds,
  }) : super(key: key);

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                '',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.courseName,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.courseCode,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300, // Set container width to screen width
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 201, 201, 201),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection:
                            Axis.vertical, // Allow vertical scrolling
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Course Overview:',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              widget.details,
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Course Info',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Professor: ${widget.professorName}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Last Semester GPA: ${widget.averageGPA}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Recommended Time: ${widget.time}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Total Credits: ${widget.creds}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                            await askAIabt(widget.courseName);
                            Navigator.of(context, rootNavigator: true).pop();
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => AIDetail(
                                result: aiResponse,
                                title: titleC,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 221, 180, 212),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30)),
                          child: Text(
                            "Ask AI about this Course",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommentsSection extends StatefulWidget {
  @override
  _CommentsSectionState createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final List<Map<String, String>> comments = [
    {
      'userName': 'John Doe',
      'comment':
          'Great course! I learned a lot and the professor was very helpful.'
    },
    {
      'userName': 'Jane Smith',
      'comment': 'The course was challenging, but the content was excellent.'
    },
    {
      'userName': 'Michael Johnson',
      'comment': 'I enjoyed the practical projects in this course.'
    },
    {
      'userName': 'Emily Davis',
      'comment':
          'The course was well-structured and the professor was very knowledgeable.'
    },
  ];

  final TextEditingController _commentController = TextEditingController();

  void _addComment() {
    setState(() {
      comments.add({
        'userName':
            'Anonymous', // Replace with the actual user's name if available
        'comment': _commentController.text,
      });
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comments:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  for (var comment in comments)
                    CommentCard(
                      userName: comment['userName']!,
                      comment: comment['comment']!,
                    ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Add a comment',
                    hintStyle: TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 14.0,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 8.0),
              IconButton(
                icon: Icon(Icons.send, color: Colors.white),
                onPressed: _addComment,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CommentCard extends StatelessWidget {
  final String userName;
  final String comment;

  const CommentCard({
    Key? key,
    required this.userName,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    comment,
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 16.0),
          Column(
            children: [
              Text(
                'Ratings:',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: Colors.red,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '5 Stars',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '4 Stars',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: Colors.green,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '3 Stars',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: Colors.yellow,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '2 Stars',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '1 Stars',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    color: Colors.blue,
                    value: 20,
                    title: '20%',
                    radius: 50,
                    titleStyle: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  PieChartSectionData(
                    color: Colors.red,
                    value: 30,
                    title: '30%',
                    radius: 50,
                    titleStyle: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  PieChartSectionData(
                    color: Colors.green,
                    value: 20,
                    title: '20%',
                    radius: 50,
                    titleStyle: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  PieChartSectionData(
                    color: Colors.yellow,
                    value: 10,
                    title: '10%',
                    radius: 50,
                    titleStyle: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  PieChartSectionData(
                    color: Colors.orange,
                    value: 20,
                    title: '20%',
                    radius: 50,
                    titleStyle: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
                borderData: FlBorderData(show: false),
                sectionsSpace: 2,
                centerSpaceRadius: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
