import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class TimetableManagerCubit extends Cubit<TimetableManagerState> {
  final TimetableManagerUseCase _useCase;
  TimetableManagerCubit(this._useCase) : super(TimetableManagerInit());

}
