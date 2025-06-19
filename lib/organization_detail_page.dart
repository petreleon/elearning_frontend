import 'package:flutter/material.dart';
import 'models.dart';
import 'course_card.dart';
import 'mock_data.dart';

class OrganizationDetailPage extends StatefulWidget {
  const OrganizationDetailPage({super.key});

  @override
  State<OrganizationDetailPage> createState() => _OrganizationDetailPageState();
}

class _OrganizationDetailPageState extends State<OrganizationDetailPage> {
  String searchQuery = '';
  String selectedLevel = 'All';

  final List<String> levels = ['All', 'Beginner', 'Intermediate', 'Advanced'];

  List<Course> getCourses(String organizationId) {
    // In a real app, filter by organizationId
    return mockCourses;
  }

  List<Course> get filteredCourses {
    final organization =
        ModalRoute.of(context)?.settings.arguments as Organization?;
    if (organization == null) {
      return [];
    }

    final courses = getCourses(organization.id);

    return courses.where((course) {
      final matchesSearch = course.title
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          course.description
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          course.instructor.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesLevel =
          selectedLevel == 'All' || course.level == selectedLevel;
      return matchesSearch && matchesLevel;
    }).toList();
  }

  void _showApplyDialog(Organization organization) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Apply to ${organization.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('You are about to apply to join ${organization.name}.'),
              const SizedBox(height: 16),
              const Text(
                  'This will send your application for review. You will be notified once it has been processed.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Application sent to ${organization.name}!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the organization from route arguments
    final organization =
        ModalRoute.of(context)?.settings.arguments as Organization?;

    // If no organization is provided, show error
    if (organization == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Organization Not Found'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Organization not found',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Please go back and select an organization',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(organization.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Organization Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  // Organization Logo
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.business,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Organization Name
                  Text(
                    organization.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Organization Description
                  Text(
                    organization.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Course Count
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${organization.courseCount} courses available',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Apply to Join Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showApplyDialog(organization),
                      icon: const Icon(Icons.add_circle_outline),
                      label: const Text('Apply to Join'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search and Filter Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search courses...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  // Level Filter
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: levels.length,
                      itemBuilder: (context, index) {
                        final level = levels[index];
                        final isSelected = level == selectedLevel;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(level),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                selectedLevel = level;
                              });
                            },
                            backgroundColor: Colors.grey[200],
                            selectedColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Courses List - Remove Expanded and use shrinkWrap
            filteredCourses.isEmpty
                ? SizedBox(
                    height: 200,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No courses found',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = filteredCourses[index];
                      return CourseCard(course: course);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
