import 'package:flutter/material.dart';
import '../models.dart';
import 'course_card.dart';

class CoursesYouMayLike extends StatelessWidget {
  final List<Course> courses;
  const CoursesYouMayLike({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Courses You May Like',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CourseCard(course: courses[index]),
            );
          },
        ),
      ],
    );
  }
}
