import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class HODAssignmentCubit extends Cubit<HODAssignmentState> {
  final HODAssignmentUseCase _useCase;
  HODAssignmentCubit(this._useCase) : super(HODAssignmentInit());

}
