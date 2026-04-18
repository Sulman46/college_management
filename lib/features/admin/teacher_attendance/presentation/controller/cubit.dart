import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class TeacherAttendanceCubit extends Cubit<TeacherAttendanceState> {
  final TeacherAttendanceUseCase _useCase;
  TeacherAttendanceCubit(this._useCase) : super(TeacherAttendanceInit());

}
