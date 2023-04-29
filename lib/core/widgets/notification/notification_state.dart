part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  final String message;
  final String? actionMessage;
  final VoidCallback? action;

  const NotificationState({
    required this.message,
    this.action,
    this.actionMessage,
  });
}

class NotificationInitial extends NotificationState {
  const NotificationInitial({
    required super.message,
    super.action,
    super.actionMessage,
  });

  @override
  List<Object> get props => [];
}

class NotificationSuccess extends NotificationState {
  const NotificationSuccess({
    required super.message,
    super.action,
    super.actionMessage,
  });

  @override
  List<Object> get props => [];
}

class NotificationError extends NotificationState {
  const NotificationError({
    required super.message,
    super.action,
    super.actionMessage,
  });

  @override
  List<Object> get props => [];
}

class NotificationInfo extends NotificationState {
  const NotificationInfo({
    required super.message,
    super.action,
    super.actionMessage,
  });

  @override
  List<Object> get props => [];
}
