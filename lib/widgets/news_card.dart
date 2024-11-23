import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String summary;
  const NewsCard({
    required this.title,
    required this.summary,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Optional: You can adjust the radius of the border
        side: BorderSide(color: const Color.fromARGB(255, 0, 0, 0), width: 1.0), // Adjust the color and width of the border
      ),
      color: Color.fromARGB(255, 255, 255, 255),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              summary,
              style: const TextStyle(
                fontSize: 14.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ), // Smaller font for professor name
            ),
          ],
        ),
      ),
    );
  }
}
