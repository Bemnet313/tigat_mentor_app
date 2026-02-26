import 'package:flutter/material.dart';
import '../../../core/design/tokens.dart';
import '../../../core/mock_data/course_mock_data.dart';
import '../models/course_model.dart';
import '../widgets/course_card.dart';
import 'course_edit_screen.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Course> _publishedCourses = List.from(mockPublishedCourses);
  final List<Course> _draftCourses = List.from(mockDraftCourses);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showDeleteDialog(Course course, bool isPublished) {
    final passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppTokens.backgroundLight,
        title: const Text("Confirm Deletion"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Are you sure you want to delete '${course.title}'? This action cannot be undone."),
            const SizedBox(height: AppTokens.spacingLg),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Enter Password",
                hintText: "Enter your password to confirm",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: AppTokens.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              // In a real app, verify password here
              if (passwordController.text.isNotEmpty) {
                setState(() {
                  if (isPublished) {
                    _publishedCourses.removeWhere((c) => c.id == course.id);
                  } else {
                    _draftCourses.removeWhere((c) => c.id == course.id);
                  }
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Course deleted successfully")),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTokens.statusRed),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _showVisibilityDialog(Course course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppTokens.backgroundLight,
        title: const Text("Change Visibility"),
        content: Text("Are you sure you want to change the visibility of '${course.title}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: AppTokens.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final index = _publishedCourses.indexWhere((c) => c.id == course.id);
                if (index != -1) {
                  _publishedCourses[index] = _publishedCourses[index].copyWith(
                    isPublic: !_publishedCourses[index].isPublic,
                  );
                }
              });
              Navigator.pop(context);
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  void _showPublishDialog(Course course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppTokens.backgroundLight,
        title: const Text("Publish Course"),
        content: Text("Are you sure you are ready to make '${course.title}' live?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: AppTokens.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _draftCourses.removeWhere((c) => c.id == course.id);
                _publishedCourses.insert(0, course.copyWith(status: CourseStatus.published));
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Course published successfully!")),
              );
            },
            child: const Text("Publish Now"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Courses"),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTokens.primaryOlive,
          labelColor: AppTokens.primaryOlive,
          unselectedLabelColor: AppTokens.textSecondary,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: "Published"),
            Tab(text: "Drafts"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCourseList(_publishedCourses, true),
          _buildCourseList(_draftCourses, false),
        ],
      ),
    );
  }

  Widget _buildCourseList(List<Course> courses, bool isPublished) {
    if (courses.isEmpty) {
      return Center(
        child: Text(
          isPublished ? "No published courses yet" : "No drafts yet",
          style: const TextStyle(color: AppTokens.textSecondary),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppTokens.spacingLg),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return CourseCard(
          course: course,
          onEdit: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseEditScreen(course: course),
              ),
            );
          },
          onDelete: () => _showDeleteDialog(course, isPublished),
          onToggleVisibility: isPublished ? () => _showVisibilityDialog(course) : null,
          onPublish: !isPublished ? () => _showPublishDialog(course) : null,
        );
      },
    );
  }
}
