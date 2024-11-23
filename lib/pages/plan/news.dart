import 'package:flutter/material.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/model/courses.dart';
import 'package:project_ss/widgets/news_card.dart';

class NewsInfo extends StatefulWidget {
  const NewsInfo({super.key});

  @override
  State<NewsInfo> createState() => _NewsInfoState();
}

class _NewsInfoState extends State<NewsInfo> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: newsRecruitmentList.length,
      itemBuilder: (context, index) {
        final news = newsRecruitmentList[index];
        return NewsCard(title: news.title, summary: news.summary);
      },
    );
  }
}
