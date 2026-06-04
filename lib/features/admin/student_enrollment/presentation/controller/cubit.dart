import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class StudentEnrollmentCubit extends Cubit<StudentEnrollmentState> {
  final StudentEnrollmentUseCase _useCase;
  StudentEnrollmentCubit(this._useCase) : super(StudentEnrollmentInit());

}
