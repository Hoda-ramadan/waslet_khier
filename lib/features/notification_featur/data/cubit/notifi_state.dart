import 'package:waslet_khier/features/notification_featur/data/model/notifi_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;
  NotificationSuccess({required this.notifications});
}

class NotificationFailure extends NotificationState {
  final String errorMessage;
  NotificationFailure({required this.errorMessage});
}

class NotificationDeleteSuccess extends NotificationState {}
