import 'package:flutter/material.dart';
import 'mock_data.dart';
import 'models.dart';
import 'last_visited_course.dart';
import 'courses_you_may_like.dart';
import 'session_manager.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  String? username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final user = await SessionManager.getCurrentUser();
    setState(() {
      username = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    // For demonstration, pick the first course as last visited
    final lastVisited = mockCourses.isNotEmpty ? mockCourses.first : null;
    // For demonstration, recommend all courses except the last visited
    final recommended =
        mockCourses.length > 1 ? mockCourses.sublist(1) : <Course>[];

    return Scaffold(
      appBar: AppBar(
        title: Text(
            username != null ? 'Welcome, $username!' : 'Learning Dashboard'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => _showUserMenu(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to your learning dashboard!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              LastVisitedCourse(course: lastVisited),
              const SizedBox(height: 32),
              CoursesYouMayLike(courses: recommended),
            ],
          ),
        ),
      ),
    );
  }

  void _showUserMenu(BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(1000, 100, 0, 0),
      items: [
        const PopupMenuItem(
          value: 'organizations',
          child: Row(
            children: [
              Icon(Icons.business, size: 20),
              SizedBox(width: 8),
              Text('Organizations'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person, size: 20),
              SizedBox(width: 8),
              Text('Profile'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'organizations') {
        Navigator.pushNamed(context, '/organizations');
      } else if (value == 'profile') {
        Navigator.pushNamed(context, '/profile');
      }
    });
  }
}
