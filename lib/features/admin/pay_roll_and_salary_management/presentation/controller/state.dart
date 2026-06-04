import 'package:equatable/equatable.dart';

abstract class PayrollAndSalaryManagementState extends Equatable{
@override // TODO: implement props
  List<Object?> get props => [];
}

class PayrollAndSalaryManagementInit extends PayrollAndSalaryManagementState{}
class PayrollAndSalaryManagementLoading extends PayrollAndSalaryManagementState{}
class PayrollAndSalaryManagementLoaded extends PayrollAndSalaryManagementState{}
class PayrollAndSalaryManagementError extends PayrollAndSalaryManagementState{}
