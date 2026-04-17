import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class AdminHomeCubit extends Cubit<AdminHomeState> {
  final AdminHomeUseCase _useCase;
  AdminHomeCubit(this._useCase) : super(AdminHomeInit());

}
