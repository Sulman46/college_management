import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class TeacherAllocationCubit extends Cubit<TeacherAllocationState> {
  final TeacherAllocationUseCase _useCase;
  TeacherAllocationCubit(this._useCase) : super(TeacherAllocationInit());

}
