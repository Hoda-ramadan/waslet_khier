import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/features/notification_featur/data/cubit/notifi_state.dart';
import 'package:waslet_khier/features/notification_featur/data/repo/notifi_repo.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo repo;

  NotificationCubit(this.repo) : super(NotificationInitial());

  Future<void> getNotifications(int donorId) async {
    emit(NotificationLoading());
    try {
      final result = await repo.getNotifications(donorId);
      emit(NotificationSuccess(notifications: result));
    } catch (e) {
      emit(
        NotificationFailure(
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> deleteNotification({
    required int notificationId,
    required int donorId,
  }) async {
    try {
      await repo.deleteNotification(notificationId);
      await getNotifications(donorId);
    } catch (e) {
      emit(
        NotificationFailure(
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }
}
