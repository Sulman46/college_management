import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class AdminProgramsCubit extends Cubit<AdminProgramsState> {
  final AdminProgramsUseCase _useCase;
  AdminProgramsCubit(this._useCase) : super(AdminProgramsInit());

}
