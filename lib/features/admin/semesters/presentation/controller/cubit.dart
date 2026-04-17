import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class SemesterAdminCubit extends Cubit<SemesterAdminState> {
  final SemesterAdminUseCase _useCase;
  SemesterAdminCubit(this._useCase) : super(SemesterAdminInit());

}
