import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class StudentRegistrationCubit extends Cubit<StudentRegistrationState> {
  final StudentRegistrationUseCase _useCase;
  StudentRegistrationCubit(this._useCase) : super(StudentRegistrationInit());

}
