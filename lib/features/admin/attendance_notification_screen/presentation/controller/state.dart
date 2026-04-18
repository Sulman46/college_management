import 'package:equatable/equatable.dart';

abstract class AttendanceNotificationState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class AttendanceNotificationInit extends AttendanceNotificationState{}
class AttendanceNotificationLoading extends AttendanceNotificationState{}
class AttendanceNotificationLoaded extends AttendanceNotificationState{}
class AttendanceNotificationError extends AttendanceNotificationState{}
