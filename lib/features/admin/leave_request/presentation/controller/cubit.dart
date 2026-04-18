import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class LeaveRequestCubit extends Cubit<LeaveRequestState> {
  final LeaveRequestUseCase _useCase;
  LeaveRequestCubit(this._useCase) : super(LeaveRequestInit());

}
