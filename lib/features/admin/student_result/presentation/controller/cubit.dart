import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class StudentResultCubit extends Cubit<StudentResultState> {
  final StudentResultUseCase _useCase;
  StudentResultCubit(this._useCase) : super(StudentResultInit());

}
