import 'package:flutter/material.dart';
import 'package:tigat_mentor_app/core/design/tokens.dart';
import 'package:tigat_mentor_app/features/courses/models/course_model.dart';
import 'package:tigat_mentor_app/features/courses/widgets/discount_bottom_sheet.dart';

class CourseEditScreen extends StatefulWidget {
  final Course course;

  const CourseEditScreen({super.key, required this.course});

  @override
  State<CourseEditScreen> createState() => _CourseEditScreenState();
}

class _CourseEditScreenState extends State<CourseEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.course.title);
    _descriptionController = TextEditingController(text: widget.course.description);
    _priceController = TextEditingController(text: widget.course.price.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _showDiscountBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DiscountBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPublished = widget.course.status == CourseStatus.published;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Course"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTokens.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Preview
            Center(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: AppTokens.elevatedShadow,
                      image: DecorationImage(
                        image: NetworkImage(widget.course.thumbnailUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: CircleAvatar(
                      backgroundColor: AppTokens.primaryOlive,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, color: Theme.of(context).colorScheme.onPrimary, size: 20),
                        onPressed: () {
                          // Thumb upload is "handled via web app" but let's keep the UI
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTokens.spacingXl),
            
            _buildFieldLabel("Course Title"),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: "Enter course title"),
            ),
            const SizedBox(height: AppTokens.spacingLg),

            _buildFieldLabel("Description"),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(hintText: "Enter course description"),
            ),
            const SizedBox(height: AppTokens.spacingLg),

            _buildFieldLabel("Price (ETB)"),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Price"),
            ),
            const SizedBox(height: AppTokens.spacingXl),

            // Discount Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.percent, color: AppTokens.primaryOlive),
                label: const Text("Add Discount", style: TextStyle(color: AppTokens.primaryOlive)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTokens.primaryOlive),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: _showDiscountBottomSheet,
              ),
            ),
            const SizedBox(height: 100), // Spacing for footer
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(AppTokens.spacingLg),
        decoration: BoxDecoration(
          color: AppTokens.backgroundLight,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            if (isPublished) ...[
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Discard Changes", style: TextStyle(color: AppTokens.textSecondary)),
                ),
              ),
              const SizedBox(width: AppTokens.spacingMd),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Save Successful")),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Update Course"),
                ),
              ),
            ] else ...[
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Save in Draft", style: TextStyle(color: AppTokens.textSecondary)),
                ),
              ),
              const SizedBox(width: AppTokens.spacingMd),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Trigger publish flow
                    _showPublishConfirmation();
                  },
                  child: const Text("Publish Now"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showPublishConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Ready to Live?"),
        content: const Text("Are you sure you are ready to make this course live?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to list
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Course published and now live!")),
              );
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTokens.spacingSm),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, color: AppTokens.textPrimary),
      ),
    );
  }
}
