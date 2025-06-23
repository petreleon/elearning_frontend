class Organization {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int courseCount;
  final List<String> categories;

  Organization({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.courseCount,
    required this.categories,
  });
}

class Course {
  final String id;
  final String organizationId;
  final String title;
  final String description;
  final String instructor;
  final Duration duration;
  final String level;
  final double rating;
  final int enrolledStudents;

  Course({
    required this.id,
    required this.organizationId,
    required this.title,
    required this.description,
    required this.instructor,
    required this.duration,
    required this.level,
    required this.rating,
    required this.enrolledStudents,
  });
}
