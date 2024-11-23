import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/pages/course_page.dart';
import 'package:project_ss/pages/result_page.dart';
import 'package:project_ss/pages/schedule_page.dart';
import 'package:project_ss/services/navigation.dart';
import 'package:project_ss/widgets/bottom_navbar.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_animation.value, 0),
                  child: child,
                );
              },
              child: Image.asset('lib/assets/Logo.png'),
            ),
            Text(
              'AI is COOKING',
              key: ValueKey<int>(1),
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Please Wait...',
              key: ValueKey<int>(2),
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Column(
          children: [
            for (var i in courseNums) ...[
              Text(
                i,
                style: TextStyle(fontSize: 24),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
