import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class FacultyWorkLoadCubit extends Cubit<FacultyWorkLoadState> {
  final FacultyWorkLoadUseCase _useCase;
  FacultyWorkLoadCubit(this._useCase) : super(FacultyWorkLoadInit());

}
