import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class AdminDepartmentCubit extends Cubit<AdminDepartmentState> {
  final AdminDepartmentUseCase _useCase;
  AdminDepartmentCubit(this._useCase) : super(AdminDepartmentInit());

}
