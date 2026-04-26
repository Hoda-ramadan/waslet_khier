import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final int? id;
  final String? userId;
  final String? title;
  final String? message;
  final bool? isRead;
  final DateTime? createdAt;

  const NotificationModel({
    this.id,
    this.userId,
    this.title,
    this.message,
    this.isRead,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      isRead: json['isRead'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'message': message,
    'isRead': isRead,
    'createdAt': createdAt?.toIso8601String(),
  };

  @override
  List<Object?> get props {
    return [id, userId, title, message, isRead, createdAt];
  }
}
