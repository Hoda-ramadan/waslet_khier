import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/notification_featur/data/model/notification_modell.dart';

class NotificationRepo {
  final ApiService apiService;
  final String token;

  NotificationRepo(this.apiService, {required this.token});

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final data = await apiService.getWithToken(
        endPoint: '/Notification/ToUser',
        token: token,
      );
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
      await apiService.delete(endPoint: '/Notification/$notificationId');
    } catch (_) {}
  }
}
