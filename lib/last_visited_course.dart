import 'package:flutter/material.dart';
import 'models.dart';
import 'course_card.dart';

class LastVisitedCourse extends StatelessWidget {
  final Course? course;
  const LastVisitedCourse({super.key, this.course});

  @override
  Widget build(BuildContext context) {
    if (course == null) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Last Course You Visited',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        CourseCard(course: course!),
      ],
    );
  }
}
