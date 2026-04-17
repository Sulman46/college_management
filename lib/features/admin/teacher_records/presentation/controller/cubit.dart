import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class TeacherRecordsCubit extends Cubit<TeacherRecordsState> {
  final TeacherRecordsUseCase _useCase;
  TeacherRecordsCubit(this._useCase) : super(TeacherRecordsInit());

}
