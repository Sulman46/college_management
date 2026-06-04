import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class PayrollAndSalaryManagementCubit extends Cubit<PayrollAndSalaryManagementState> {
  final PayrollAndSalaryManagementUseCase _useCase;
  PayrollAndSalaryManagementCubit(this._useCase) : super(PayrollAndSalaryManagementInit());

}
