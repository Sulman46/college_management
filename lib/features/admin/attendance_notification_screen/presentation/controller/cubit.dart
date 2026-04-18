import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class AttendanceNotificationCubit extends Cubit<AttendanceNotificationState> {
  final AttendanceNotificationUseCase _useCase;
  AttendanceNotificationCubit(this._useCase) : super(AttendanceNotificationInit());

}
