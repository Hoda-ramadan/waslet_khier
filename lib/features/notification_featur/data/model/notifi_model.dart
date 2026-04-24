class NotificationModel {
  final int? id;
  final String? title;
  final String? message;
  final String? createdAt;
  final bool? isRead;

  NotificationModel({
    this.id,
    this.title,
    this.message,
    this.createdAt,
    this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      createdAt: json['createdAt'] as String?,
      isRead: json['isRead'] as bool?,
    );
  }
}
