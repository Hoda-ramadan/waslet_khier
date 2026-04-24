import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/notification_featur/data/model/notification_modell.dart';

class NotificationRepo {
  final ApiService apiService;

  NotificationRepo(this.apiService);

  Future<List<NotificationModel>> getNotifications(int donorId) async {
    try {
      final data = await apiService.get(endPoint: '/Notification/$donorId');
      if (data is List) {
        return data.map((e) => NotificationModel.fromJson(e)).toList();
      }
      // لو بيرجع object واحد
      return [NotificationModel.fromJson(data)];
    } catch (e) {
      if (e.toString().contains('404') || e.toString().contains('400')) {
        return [];
      }
      rethrow;
    }
  }

  Future<void> deleteNotification(int notificationId) async {
    try {
      await apiService.delete(endPoint: '/Notification/$notificationId');
    } catch (_) {}
  }
}
