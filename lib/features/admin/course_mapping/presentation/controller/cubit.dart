import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class CourseMappingCubit extends Cubit<CourseMappingState> {
  final CourseMappingUseCase _useCase;
  CourseMappingCubit(this._useCase) : super(CourseMappingInit());

}
