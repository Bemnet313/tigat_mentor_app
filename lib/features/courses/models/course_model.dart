import 'package:flutter/material.dart';

enum CourseStatus { published, draft }

class Course {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final DateTime createdAt;
  final int studentCount;
  final double price;
  final CourseStatus status;
  final bool isPublic;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.createdAt,
    this.studentCount = 0,
    required this.price,
    required this.status,
    this.isPublic = true,
  });

  Course copyWith({
    String? title,
    String? description,
    String? thumbnailUrl,
    int? studentCount,
    double? price,
    CourseStatus? status,
    bool? isPublic,
  }) {
    return Course(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      createdAt: createdAt,
      studentCount: studentCount ?? this.studentCount,
      price: price ?? this.price,
      status: status ?? this.status,
      isPublic: isPublic ?? this.isPublic,
    );
  }
}
