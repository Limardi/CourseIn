class Courses {
  Courses({
    required this.title,
    required this.content,
  });

  final String title;
  String content;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Courses && other.content == content;
  }

  @override
  int get hashCode => content.hashCode;
}

class Course {
  const Course({
    required this.title,
    required this.professor,
    required this.coursenum,
    required this.lastGPA,
    required this.department,
    required this.rating,
    required this.details,
    required this.time,
    required this.creds,
    required this.sched,
  });

  final String title;
  final String professor;
  final String coursenum;
  final double lastGPA;
  final String department;
  final double rating;
  final String details;
  final String time;
  final int creds;
  final List<String> sched;
}

class JobData {
  const JobData({
    required this.jobName,
    required this.relatedCourse,
    required this.jobOpportunities,
  });
  final String jobName;
  final String relatedCourse;
  final String jobOpportunities;
}

class NewsRecruitment {
  final String title;
  final String summary;

  NewsRecruitment({
    required this.title,
    required this.summary,
  });
}
