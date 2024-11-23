import 'package:flutter/material.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/widgets/future_card.dart';

class FutureInfo extends StatefulWidget {
  const FutureInfo({super.key});

  @override
  State<FutureInfo> createState() => _FutureInfoState();
}

class _FutureInfoState extends State<FutureInfo> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: jobDataList.length,
      itemBuilder: (context, index) {
        final job = jobDataList[index];
        return FutureCard(
            jobName: job.jobName,
            jobOpportunities: job.jobOpportunities,
            relatedCourse: job.relatedCourse);
      },
    );
  }
}
