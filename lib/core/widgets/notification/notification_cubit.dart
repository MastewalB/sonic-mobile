import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationInitial(message: ""));

  void successNotification({
    required String message,
    String? actionMessage,
    VoidCallback? action,
  }) {
    emit(NotificationSuccess(
      message: message,
      action: action,
      actionMessage: actionMessage,
    ));
  }

  void errorNotification({
    required String message,
    String? actionMessage,
    VoidCallback? action,
  }) {
    emit(NotificationError(
      message: message,
      action: action,
      actionMessage: actionMessage,
    ));
  }

  void infoNotification({
    required String message,
    String? actionMessage,
    VoidCallback? action,
  }) {
    emit(NotificationInfo(
      message: message,
      action: action,
      actionMessage: actionMessage,
    ));
  }

  void notificationInitital() {
    emit(const NotificationInitial(message: ""));
  }
}
