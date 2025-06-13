import 'package:flutter/material.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Dashboard'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => _showUserMenu(context),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Navigate back to welcome page and clear navigation stack
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildCourseCard(
                    'Mathematics',
                    Icons.calculate,
                    Colors.blue,
                    context,
                  ),
                  _buildCourseCard(
                    'Science',
                    Icons.science,
                    Colors.green,
                    context,
                  ),
                  _buildCourseCard(
                    'History',
                    Icons.history_edu,
                    Colors.orange,
                    context,
                  ),
                  _buildCourseCard(
                    'Literature',
                    Icons.book,
                    Colors.red,
                    context,
                  ),
                  _buildCourseCard(
                    'Art',
                    Icons.palette,
                    Colors.purple,
                    context,
                  ),
                  _buildCourseCard(
                    'Music',
                    Icons.music_note,
                    Colors.teal,
                    context,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUserMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000, 100, 0, 0),
      items: [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.business, size: 20),
              SizedBox(width: 8),
              Text('Organizations'),
            ],
          ),
          value: 'organizations',
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.person, size: 20),
              SizedBox(width: 8),
              Text('Profile'),
            ],
          ),
          value: 'profile',
        ),
      ],
    ).then((value) {
      if (value == 'organizations') {
        Navigator.pushNamed(context, '/organizations');
      } else if (value == 'profile') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile page coming soon')),
        );
      }
    });
  }

  Widget _buildCourseCard(
      String title, IconData icon, Color color, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title course selected')),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.7), color],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
