import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/notification_featur/data/model/notifi_model.dart';

class NotificationRepo {
  final ApiService apiService;

  NotificationRepo(this.apiService);

  Future<List<NotificationModel>> getNotifications(String userId) async {
    try {
      final data = await apiService.get(endPoint: '/Notification/user/$userId');
      if (data is List) {
        return data.map((e) => NotificationModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      if (e.toString().contains('404') || e.toString().contains('400'))
        return [];
      rethrow;
    }
  }

  Future<void> deleteNotification(int notificationId) async {
    try {
      await apiService.get(endPoint: '/Notification/$notificationId');
    } catch (_) {}
  }
}
