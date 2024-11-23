import 'package:flutter/material.dart';
import 'package:project_ss/pages/course_filling_page.dart';
import 'package:project_ss/services/navigation.dart';
import 'package:provider/provider.dart';

class BeforeGettingStarted extends StatefulWidget {
  @override
  _BeforeGettingStartedState createState() => _BeforeGettingStartedState();
}

class _BeforeGettingStartedState extends State<BeforeGettingStarted> {
  int? _selectedSemester; // Variable to hold the selected semester
  // Helper function to get the ordinal suffix
  String _getOrdinalSuffix(int number) {
    if (number >= 11 && number <= 13) {
      return 'th';
    }
    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  void _onNextPressed() {
    // Handle the "Next" button press, navigate to the course selection page
    if (_selectedSemester != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CourseFillingPage(semester: _selectedSemester!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //final nav = Provider.of<NavigationService>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Before Getting Started',
              //style: Theme.of(context).textTheme.headline3?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20), // Add some space between the texts
            const Text(
              'We would like to know what semester you are currently in',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center, // Center align the text
            ),
            const SizedBox(height: 20), // Add some space before the box
            PopupMenuButton<int>(
              surfaceTintColor: Colors.white,
              color: Colors.white,
              onSelected: (int result) {
                setState(() {
                  _selectedSemester = result; // Update the selected semester
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('1st Semester'),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text('2nd Semester'),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text('3rd Semester'),
                ),
                const PopupMenuItem<int>(
                  value: 4,
                  child: Text('4th Semester'),
                ),
                const PopupMenuItem<int>(
                  value: 5,
                  child: Text('5th Semester'),
                ),
                const PopupMenuItem<int>(
                  value: 6,
                  child: Text('6th Semester'),
                ),
                const PopupMenuItem<int>(
                  value: 7,
                  child: Text('7th Semester'),
                ),
                const PopupMenuItem<int>(
                  value: 8,
                  child: Text('8th Semester'),
                ),
              ],
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.transparent),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedSemester == null
                          ? 'Please Select the Semester'
                          : '$_selectedSemester${_getOrdinalSuffix(_selectedSemester!)} Semester',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), // Add some space before the button
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0), // Adjust the padding around the button
              child: TextButton(
                onPressed: () {
                  _onNextPressed();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          13.0), // Adjust the radius as needed
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 221, 180, 212)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal:
                              30.0)), // Increase padding inside the button
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0, // Increase font size if needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
