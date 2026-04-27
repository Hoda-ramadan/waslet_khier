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
  print('🔍 id: ${json['id']} (${json['id'].runtimeType})');
  print('🔍 userId: ${json['userId']} (${json['userId'].runtimeType})');
  print('🔍 title: ${json['title']} (${json['title'].runtimeType})');
  print('🔍 message: ${json['message']} (${json['message'].runtimeType})');
  print('🔍 isRead: ${json['isRead']} (${json['isRead'].runtimeType})');
  print('🔍 createdAt: ${json['createdAt']} (${json['createdAt'].runtimeType})');

  return NotificationModel(
    id: json['id'] as int?,
    userId: json['userId']?.toString(),
    title: json['title']?.toString(),
    message: json['message']?.toString(),
    isRead: json['isRead'] as bool?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'].toString()),
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
